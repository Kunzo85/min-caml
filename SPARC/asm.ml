(* SPARC assembly with a few virtual instructions *)

open Location

type id_or_imm = V of Id.t | C of int
type t = (* 命令の列 (caml2html: sparcasm_t) *)
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
and exp' = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
  | Nop
  | Set of int
  | SetL of Id.l
  | Mov of Id.t
  | Neg of Id.t
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm
  | SLL of Id.t * id_or_imm
  | Ld of Id.t * id_or_imm
  | St of Id.t * Id.t * id_or_imm
  | FMovD of Id.t
  | FNegD of Id.t
  | FAddD of Id.t * Id.t
  | FSubD of Id.t * Id.t
  | FMulD of Id.t * Id.t
  | FDivD of Id.t * Id.t
  | LdDF of Id.t * id_or_imm
  | StDF of Id.t * Id.t * id_or_imm
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * id_or_imm * t * t
  | IfLE of Id.t * id_or_imm * t * t
  | IfGE of Id.t * id_or_imm * t * t (* 左右対称ではないので必要 *)
  | IfFEq of Id.t * Id.t * t * t
  | IfFLE of Id.t * Id.t * t * t
  (* closure address, integer arguments, and float arguments *)
  | CallCls of Id.t * Id.t list * Id.t list
  | CallDir of Id.l * Id.t list * Id.t list
  | Save of Id.t * Id.t (* レジスタ変数の値をスタック変数へ保存 (caml2html: sparcasm_save) *)
  | Restore of Id.t (* スタック変数から値を復元 (caml2html: sparcasm_restore) *)
and exp = exp' with_loc

type fundef' = { name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }
type fundef = fundef' with_loc

(* プログラム全体 = 浮動小数点数テーブル + トップレベル関数 + メインの式 (caml2html: sparcasm_prog) *)
type prog = Prog of (Id.l * float) list * fundef list * t

let fletd(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let regs = (* Array.init 16 (fun i -> Printf.sprintf "%%r%d" i) *)
  [| "%i2"; "%i3"; "%i4"; "%i5";
     "%l0"; "%l1"; "%l2"; "%l3"; "%l4"; "%l5"; "%l6"; "%l7";
     "%o0"; "%o1"; "%o2"; "%o3"; "%o4"; "%o5" |]
let fregs = Array.init 16 (fun i -> Printf.sprintf "%%f%d" (i * 2))
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
let reg_cl = regs.(Array.length regs - 2) (* closure address (caml2html: sparcasm_regcl) *)
let reg_sw = regs.(Array.length regs - 1) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)
let reg_sp = "%i0" (* stack pointer *)
let reg_hp = "%i1" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_ra = "%o7" (* return address *)
let is_reg x = (x.[0] = '%')
let co_freg_table =
  let ht = Hashtbl.create 16 in
  for i = 0 to 15 do
    Hashtbl.add
      ht
      (Printf.sprintf "%%f%d" (i * 2))
      (Printf.sprintf "%%f%d" (i * 2 + 1))
  done;
  ht
let co_freg freg = Hashtbl.find co_freg_table freg (* "companion" freg *)

(* super-tenuki *)
let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp e =
  match e.node with
  | Nop | Set(_) | SetL(_) | Comment(_) | Restore(_) -> []
  | Mov(x) | Neg(x) | FMovD(x) | FNegD(x) | Save(x, _) -> [x]
  | Add(x, y') | Sub(x, y') | SLL(x, y') | Ld(x, y') | LdDF(x, y') -> x :: fv_id_or_imm y'
  | St(x, y, z') | StDF(x, y, z') -> x :: y :: fv_id_or_imm z'
  | FAddD(x, y) | FSubD(x, y) | FMulD(x, y) | FDivD(x, y) -> [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> x :: y :: remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs
  | CallDir(_, ys, zs) -> ys @ zs
and fv = function
  | Ans(exp) -> fv_exp exp
  | Let((x, t), exp, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e)
let fv e = remove_and_uniq S.empty (fv e)

let rec concat e1 xt e2 =
  match e1 with
  | Ans(exp) -> Let(xt, exp, e2)
  | Let(yt, exp, e1') -> Let(yt, exp, concat e1' xt e2)

let align i = (if i mod 8 = 0 then i else i + 4)

let id_or_imm_to_string = function
  | V(x) -> x
  | C(i) -> string_of_int i

let rec exp_to_string p e =
  match e.node with
  | Nop -> "Nop"
  | Set(i) -> Printf.sprintf "Set(%d)" i
  | SetL(Id.L(l)) -> Printf.sprintf "SetL(%s)" l
  | Mov(x) -> Printf.sprintf "Mov(%s)" x
  | Neg(x) -> Printf.sprintf "Neg(%s)" x
  | Add(x, y) -> Printf.sprintf "Add(%s, %s)" x (id_or_imm_to_string y)
  | Sub(x, y) -> Printf.sprintf "Sub(%s, %s)" x (id_or_imm_to_string y)
  | SLL(x, y) -> Printf.sprintf "SLL(%s, %s)" x (id_or_imm_to_string y)
  | Ld(x, y) -> Printf.sprintf "Ld(%s, %s)" x (id_or_imm_to_string y)
  | St(x, y, z) -> Printf.sprintf "St(%s, %s, %s)" x y (id_or_imm_to_string z)
  | FMovD(x) -> Printf.sprintf "FMovD(%s)" x
  | FNegD(x) -> Printf.sprintf "FNegD(%s)" x
  | FAddD(x, y) -> Printf.sprintf "FAddD(%s, %s)" x y
  | FSubD(x, y) -> Printf.sprintf "FSubD(%s, %s)" x y
  | FMulD(x, y) -> Printf.sprintf "FMulD(%s, %s)" x y
  | FDivD(x, y) -> Printf.sprintf "FDivD(%s, %s)" x y
  | LdDF(x, y) -> Printf.sprintf "LdDF(%s, %s)" x (id_or_imm_to_string y)
  | StDF(x, y, z) -> Printf.sprintf "StDF(%s, %s, %s)" x y (id_or_imm_to_string z)
  | Comment(s) -> Printf.sprintf "Comment(%s)" s
  | IfEq(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfEq %s %s Then\n%s\n%sElse\n%s)" 
        x (id_or_imm_to_string y) then_str (Indent.indent p) else_str
  | IfLE(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfLE %s %s Then\n%s\n%sElse\n%s)" 
        x (id_or_imm_to_string y) then_str (Indent.indent p) else_str
  | IfGE(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfGE %s %s Then\n%s\n%sElse\n%s)" 
        x (id_or_imm_to_string y) then_str (Indent.indent p) else_str
  | IfFEq(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfFEq %s %s Then\n%s\n%sElse\n%s)" 
        x y then_str (Indent.indent p) else_str
  | IfFLE(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfFLE %s %s Then\n%s\n%sElse\n%s)" 
        x y then_str (Indent.indent p) else_str
  | CallCls(x, ys, zs) -> 
      Printf.sprintf "CallCls(%s, [%s], [%s])" x (String.concat "; " ys) (String.concat "; " zs)
  | CallDir(Id.L(l), ys, zs) -> 
      Printf.sprintf "CallDir(%s, [%s], [%s])" l (String.concat "; " ys) (String.concat "; " zs)
  | Save(x, y) -> Printf.sprintf "Save(%s, %s)" x y
  | Restore(x) -> Printf.sprintf "Restore(%s)" x

and t_to_string p = function
  | Ans(e) -> exp_to_string p e
  | Let((x, t), e, body) ->
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ exp_to_string p e) in
      let body_str = Indent.indent p ^ t_to_string p body in
      Printf.sprintf 
        "(Let %s:%s =\n%s\n%sIn\n%s)"
        x (Type.t_to_string t) e_str (Indent.indent p) body_str

let fundef_to_string p { node = { name = Id.L(l); args = ys; fargs = zs; body = e; ret = t }; loc = _ } =
  let args_str = String.concat " " ys in
  let fargs_str = String.concat " " zs in
  let body_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e) in
  Printf.sprintf 
    "Function %s Args(%s) FArgs(%s) Ret:%s =\n%s"
    l args_str fargs_str (Type.t_to_string t) body_str

let prog_to_string p (Prog(floattbl, fundefs, e)) =
  let floattbl_str = 
    if List.length floattbl = 0 then ""
    else 
      let entries = List.map (fun (Id.L(l), f) -> Printf.sprintf "  %s: %s" l (string_of_float f)) floattbl in
      "Float Table:\n" ^ String.concat "\n" entries ^ "\n\n"
  in
  let fundefs_str = String.concat "\n\n" (List.map (fundef_to_string p) fundefs) in
  let e_str = t_to_string p e in
  Printf.sprintf 
    "%sToplevel Functions:\n%s\n\nMain Expression:\n%s\n"
    floattbl_str fundefs_str e_str

let print filename ext prog =
  MyPrint.print filename ext prog_to_string prog
