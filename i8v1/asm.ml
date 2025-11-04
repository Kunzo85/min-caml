(* i8v1/asm.ml *)
(* ベースはPowerPC *)

open Location

type id_or_imm = V of Id.t | C of int
type t = (* 命令の列 (caml2html: sparcasm_t) *)
  | Ans of exp
  | Let of (Id.t * Type.t) * exp * t
and exp' = (* 一つ一つの命令に対応する式 (caml2html: sparcasm_exp) *)
  | Nop
  | Li of int
  | FLi of float (* 即値としての浮動小数点数。浮動小数点数テーブルは使わない。 *)
  | SetL of Id.l
  | Mr of Id.t
  | Neg of Id.t (* 後に Sub + %zero に変換 *)
  | Add of Id.t * id_or_imm
  | Sub of Id.t * id_or_imm (* 即値がある場合はいずれAddiに変換 *)
  | Slw of Id.t * id_or_imm (* いらない？？ *)
  | Load of Id.t * id_or_imm (* いずれ必ず即値に *)
  | Store of Id.t * Id.t * id_or_imm (* いずれ必ず即値に *)
  | FMr of Id.t
  | FNeg of Id.t 
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | FLoad of Id.t * id_or_imm (* いずれ必ず即値に *)
  | FStore of Id.t * Id.t * id_or_imm (* いずれ必ず即値に *)
  | Comment of string
  (* virtual instructions *)
  | IfEq of Id.t * Id.t * t * t (* branch命令しかないので、id_or_immは使わない *)
  | IfLE of Id.t * Id.t * t * t
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

(* プログラム全体 = トップレベル関数 + メインの式 (caml2html: sparcasm_prog) *)
type prog = Prog of fundef list * t

let fletd(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let regs = Array.init 28 (fun i -> Printf.sprintf "%%r%d" (i + 1)) (* r1~r28 *)
let fregs = Array.init 32 (fun i -> Printf.sprintf "%%f%d" i)
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
let reg_cl = regs.(Array.length regs - 1) (* closure address (caml2html: sparcasm_regcl) *)
let reg_sw = regs.(Array.length regs - 2) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)
let reg_zero = "%r0" (* constant 0 *)
let reg_sp = "%r29" (* stack pointer *)
let reg_hp = "%r30" (* heap pointer (caml2html: sparcasm_reghp) *)
let reg_ra = "%r31" (* return address *)
let is_reg x = (x.[0] = '%')

(* super-tenuki *)
(* let rec remove_and_uniq xs = function
  | [] -> []
  | x :: ys when S.mem x xs -> remove_and_uniq xs ys
  | x :: ys -> x :: remove_and_uniq (S.add x xs) ys *)

(* free variables in the order of use (for spilling) (caml2html: sparcasm_fv) *)
(* let fv_id_or_imm = function V(x) -> [x] | _ -> [] *)
(* let rec fv_exp = function
  | Nop | Li(_) | FLi(_) | SetL(_) | Comment(_) | Restore(_) -> []
  | Mr(x) | Neg(x) | FMr(x) | FNeg(x) | Save(x, _) -> [x]
  | Add(x, y') | Sub(x, y') | Slw(x, y') | Lfd(x, y') | Lwz(x, y') -> x :: fv_id_or_imm y'
  | Stw(x, y, z') | Stfd(x, y, z') -> x :: y :: fv_id_or_imm z'
  | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) -> [x; y]
  | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) ->  x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> x :: y :: remove_and_uniq S.empty (fv e1 @ fv e2) (* uniq here just for efficiency *)
  | CallCls(x, ys, zs) -> x :: ys @ zs
  | CallDir(_, ys, zs) -> ys @ zs
and fv = function
  | Ans(exp) -> fv_exp exp
  | Let((x, t), exp, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e) *)
(* let fv e = remove_and_uniq S.empty (fv e) *)

let rec concat e1 xt e2 =
  match e1 with
  | Ans(exp) -> Let(xt, exp, e2)
  | Let(yt, exp, e1') -> Let(yt, exp, concat e1' xt e2)

(* let align i = (if i mod 8 = 0 then i else i + 4) *)

let id_or_imm_to_string = function
  | V(x) -> x
  | C(i) -> string_of_int i

let rec exp_to_string p e =
  match e.node with
  | Nop -> "Nop"
  | Li(i) -> Printf.sprintf "Li(%d)" i
  | FLi(f) -> Printf.sprintf "FLi(%s)" (string_of_float f)
  | SetL(Id.L(l)) -> Printf.sprintf "SetL(%s)" l
  | Mr(x) -> Printf.sprintf "Mr(%s)" x
  | Neg(x) -> Printf.sprintf "Neg(%s)" x
  | Add(x, y) -> Printf.sprintf "Add(%s, %s)" x (id_or_imm_to_string y)
  | Sub(x, y) -> Printf.sprintf "Sub(%s, %s)" x (id_or_imm_to_string y)
  | Slw(x, y) -> Printf.sprintf "Slw(%s, %s)" x (id_or_imm_to_string y)
  | Load(x, y) -> Printf.sprintf "Load(%s, %s)" x (id_or_imm_to_string y)
  | Store(x, y, z) -> Printf.sprintf "Store(%s, %s, %s)" x y (id_or_imm_to_string z)
  | FMr(x) -> Printf.sprintf "FMr(%s)" x
  | FNeg(x) -> Printf.sprintf "FNeg(%s)" x
  | FAdd(x, y) -> Printf.sprintf "FAdd(%s, %s)" x y
  | FSub(x, y) -> Printf.sprintf "FSub(%s, %s)" x y
  | FMul(x, y) -> Printf.sprintf "FMul(%s, %s)" x y
  | FDiv(x, y) -> Printf.sprintf "FDiv(%s, %s)" x y
  | FLoad(x, y) -> Printf.sprintf "FLoad(%s, %s)" x (id_or_imm_to_string y)
  | FStore(x, y, z) -> Printf.sprintf "FStore(%s, %s, %s)" x y (id_or_imm_to_string z)
  | Comment(s) -> Printf.sprintf "Comment(%s)" s
  | IfEq(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfEq %s %s Then\n%s\n%sElse\n%s)" 
        x y then_str (Indent.indent p) else_str
  | IfLE(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      Printf.sprintf 
        "(IfLE %s %s Then\n%s\n%sElse\n%s)" 
        x y then_str (Indent.indent p) else_str
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

let prog_to_string p (Prog(fundefs, e)) =
  let fundefs_str = String.concat "\n\n" (List.map (fundef_to_string p) fundefs) in
  let e_str = t_to_string p e in
  Printf.sprintf 
    "Toplevel Functions:\n%s\n\nMain Expression:\n%s\n"
    fundefs_str e_str

let print filename ext prog =
  MyPrint.print filename ext prog_to_string prog
