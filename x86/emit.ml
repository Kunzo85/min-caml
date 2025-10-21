open Asm
open Location

external gethi : float -> int32 = "gethi"
external getlo : float -> int32 = "getlo"
let make_lnum_str loc = Printf.sprintf "\t# !%d" loc.start_pos.pos_lnum
let print_new_line_with_loc oc inst_str lnum_str =
  Printf.fprintf oc "%-32s%s\n" inst_str lnum_str


let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)
let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)
let save x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x]
let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    (let pad =
      if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in
    stackmap := !stackmap @ pad @ [x; x])
let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | y :: zs -> List.map succ (loc zs) in
  loc !stackmap
let offset x = 4 * List.hd (locate x)
let stacksize () = align (List.length !stackmap * 4)

let pp_id_or_imm = function
  | V(x) -> x
  | C(i) -> "$" ^ string_of_int i

(* 関数呼び出しのために引数を並べ替える(register shuffling) (caml2html: emit_shuffle) *)
let rec shuffle sw xys =
  (* remove identical moves *)
  let _, xys = List.partition (fun (x, y) -> x = y) xys in
  (* find acyclic moves *)
  match List.partition (fun (_, y) -> List.mem_assoc y xys) xys with
  | [], [] -> []
  | (x, y) :: xys, [] -> (* no acyclic moves; resolve a cyclic move *)
      (y, sw) :: (x, y) :: shuffle sw (List.map
                                         (function
                                           | (y', z) when y = y' -> (sw, z)
                                           | yz -> yz)
                                         xys)
  | xys, acyc -> acyc @ shuffle sw xys

type dest = Tail | NonTail of Id.t (* 末尾かどうかを表すデータ型 (caml2html: emit_dest) *)
let rec g oc = function (* 命令列のアセンブリ生成 (caml2html: emit_g) *)
  | dest, Ans(exp) -> g' oc (dest, exp)
  | dest, Let((x, t), exp, e) ->
      g' oc (NonTail(x), exp);
      g oc (dest, e)
and g' oc (dest, e) = (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  let inherit_loc node = make_wloc node e.loc in
  let lnum_str = make_lnum_str e.loc in
  match dest, e.node with
  | NonTail(_), Nop -> ()
  | NonTail(x), Set(i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t$%d, %s" i x) lnum_str
  | NonTail(x), SetL(Id.L(y)) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t$%s, %s" y x) lnum_str
  | NonTail(x), Mov(y) ->
      if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" y x) lnum_str
  | NonTail(x), Neg(y) ->
      if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" y x) lnum_str;
      print_new_line_with_loc oc (Printf.sprintf "\tnegl\t%s" x) lnum_str
  | NonTail(x), Add(y, z') ->
      if V(x) = z' then
        print_new_line_with_loc oc (Printf.sprintf "\taddl\t%s, %s" y x) lnum_str
      else
        (if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\taddl\t%s, %s" (pp_id_or_imm z') x) lnum_str)
  | NonTail(x), Sub(y, z') ->
      if V(x) = z' then
        (print_new_line_with_loc oc (Printf.sprintf "\tsubl\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\tnegl\t%s" x) lnum_str)
      else
        (if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\tsubl\t%s, %s" (pp_id_or_imm z') x) lnum_str)
  | NonTail(x), Ld(y, V(z), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t(%s,%s,%d), %s" y z i x) lnum_str
  | NonTail(x), Ld(y, C(j), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%d(%s), %s" (j * i) y x) lnum_str
  | NonTail(_), St(x, y, V(z), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, (%s,%s,%d)" x y z i) lnum_str
  | NonTail(_), St(x, y, C(j), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %d(%s)" x (j * i) y) lnum_str
  | NonTail(x), FMovD(y) ->
      if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str
  | NonTail(x), FNegD(y) ->
      if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
      print_new_line_with_loc oc (Printf.sprintf "\txorpd\tmin_caml_fnegd, %s" x) lnum_str
  | NonTail(x), FAddD(y, z) ->
      if x = z then
        print_new_line_with_loc oc (Printf.sprintf "\taddsd\t%s, %s" y x) lnum_str
      else
        (if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\taddsd\t%s, %s" z x) lnum_str)
  | NonTail(x), FSubD(y, z) ->
      if x = z then (* [XXX] ugly *)
        let ss = stacksize () in
        print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %d(%s)" z ss reg_sp) lnum_str;
        if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
        print_new_line_with_loc oc (Printf.sprintf "\tsubsd\t%d(%s), %s" ss reg_sp x) lnum_str
      else
        (if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\tsubsd\t%s, %s" z x) lnum_str)
  | NonTail(x), FMulD(y, z) ->
      if x = z then
        print_new_line_with_loc oc (Printf.sprintf "\tmulsd\t%s, %s" y x) lnum_str
      else
        (if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\tmulsd\t%s, %s" z x) lnum_str)
  | NonTail(x), FDivD(y, z) ->
      if x = z then (* [XXX] ugly *)
        let ss = stacksize () in
        print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %d(%s)" z ss reg_sp) lnum_str;
        if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
        print_new_line_with_loc oc (Printf.sprintf "\tdivsd\t%d(%s), %s" ss reg_sp x) lnum_str
      else
        (if x <> y then print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" y x) lnum_str;
         print_new_line_with_loc oc (Printf.sprintf "\tdivsd\t%s, %s" z x) lnum_str)
  | NonTail(x), LdDF(y, V(z), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t(%s,%s,%d), %s" y z i x) lnum_str
  | NonTail(x), LdDF(y, C(j), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%d(%s), %s" (j * i) y x) lnum_str
  | NonTail(_), StDF(x, y, V(z), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, (%s,%s,%d)" x y z i) lnum_str
  | NonTail(_), StDF(x, y, C(j), i) -> print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %d(%s)" x (j * i) y) lnum_str
  | NonTail(_), Comment(s) -> print_new_line_with_loc oc (Printf.sprintf "\t# %s" s) lnum_str
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y;
      print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %d(%s)" x (offset y) reg_sp) lnum_str
  | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      savef y;
      print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %d(%s)" x (offset y) reg_sp) lnum_str
  | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) when List.mem x allregs ->
      print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%d(%s), %s" (offset y) reg_sp x) lnum_str
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
      print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%d(%s), %s" (offset y) reg_sp x) lnum_str
  (* 末尾だったら計算結果を第一レジスタにセットしてret (caml2html: emit_tailret) *)
  | Tail, (Nop | St _ | StDF _ | Comment _ | Save _ as exp) ->
      g' oc (NonTail(Id.gentmp Type.Unit), inherit_loc exp);
      print_new_line_with_loc oc "\tret \t" lnum_str;
  | Tail, (Set _ | SetL _ | Mov _ | Neg _ | Add _ | Sub _ | Ld _ as exp) ->
      g' oc (NonTail(regs.(0)), inherit_loc exp);
      print_new_line_with_loc oc "\tret \t" lnum_str;
  | Tail, (FMovD _ | FNegD _ | FAddD _ | FSubD _ | FMulD _ | FDivD _ | LdDF _  as exp) ->
      g' oc (NonTail(fregs.(0)), inherit_loc exp);
      print_new_line_with_loc oc "\tret \t" lnum_str;
  | Tail, (Restore(x) as exp) ->
      (match locate x with
      | [i] -> g' oc (NonTail(regs.(0)), inherit_loc exp)
      | [i; j] when i + 1 = j -> g' oc (NonTail(fregs.(0)), inherit_loc exp)
      | _ -> assert false);
      print_new_line_with_loc oc "\tret \t" lnum_str;
  | Tail, IfEq(x, y', e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcmpl\t%s, %s" (pp_id_or_imm y') x) lnum_str;
      g'_tail_if oc e1 e2 "je" "jne" lnum_str
  | Tail, IfLE(x, y', e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcmpl\t%s, %s" (pp_id_or_imm y') x) lnum_str;
      g'_tail_if oc e1 e2 "jle" "jg" lnum_str
  | Tail, IfGE(x, y', e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcmpl\t%s, %s" (pp_id_or_imm y') x) lnum_str;
      g'_tail_if oc e1 e2 "jge" "jl" lnum_str
  | Tail, IfFEq(x, y, e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcomisd\t%s, %s" y x) lnum_str;
      g'_tail_if oc e1 e2 "je" "jne" lnum_str
  | Tail, IfFLE(x, y, e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcomisd\t%s, %s" y x) lnum_str;
      g'_tail_if oc e1 e2 "jbe" "ja" lnum_str
  | NonTail(z), IfEq(x, y', e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcmpl\t%s, %s" (pp_id_or_imm y') x) lnum_str;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "je" "jne" lnum_str
  | NonTail(z), IfLE(x, y', e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcmpl\t%s, %s" (pp_id_or_imm y') x) lnum_str;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "jle" "jg" lnum_str
  | NonTail(z), IfGE(x, y', e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcmpl\t%s, %s" (pp_id_or_imm y') x) lnum_str;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "jge" "jl" lnum_str
  | NonTail(z), IfFEq(x, y, e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcomisd\t%s, %s" y x) lnum_str;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "je" "jne" lnum_str
  | NonTail(z), IfFLE(x, y, e1, e2) ->
      print_new_line_with_loc oc (Printf.sprintf "\tcomisd\t%s, %s" y x) lnum_str;
      g'_non_tail_if oc (NonTail(z)) e1 e2 "jbe" "ja" lnum_str
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs lnum_str;
      print_new_line_with_loc oc (Printf.sprintf "\tjmp\t*(%s)" reg_cl) lnum_str;
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args oc [] ys zs lnum_str;
      print_new_line_with_loc oc (Printf.sprintf "\tjmp\t%s" x) lnum_str;
  | NonTail(a), CallCls(x, ys, zs) ->
      g'_args oc [(x, reg_cl)] ys zs lnum_str;
      let ss = stacksize () in
      if ss > 0 then print_new_line_with_loc oc (Printf.sprintf "\taddl\t$%d, %s" ss reg_sp) lnum_str;
      print_new_line_with_loc oc (Printf.sprintf "\tcall\t*(%s)" reg_cl) lnum_str;
      if ss > 0 then print_new_line_with_loc oc (Printf.sprintf "\tsubl\t$%d, %s" ss reg_sp) lnum_str;
      if List.mem a allregs && a <> regs.(0) then
        print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" regs.(0) a) lnum_str
      else if List.mem a allfregs && a <> fregs.(0) then
        print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" fregs.(0) a) lnum_str
  | NonTail(a), CallDir(Id.L(x), ys, zs) ->
      g'_args oc [] ys zs lnum_str;
      let ss = stacksize () in
      if ss > 0 then print_new_line_with_loc oc (Printf.sprintf "\taddl\t$%d, %s" ss reg_sp) lnum_str;
      print_new_line_with_loc oc (Printf.sprintf "\tcall\t%s" x) lnum_str;
      if ss > 0 then print_new_line_with_loc oc (Printf.sprintf "\tsubl\t$%d, %s" ss reg_sp) lnum_str;
      if List.mem a allregs && a <> regs.(0) then
        print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" regs.(0) a) lnum_str
      else if List.mem a allfregs && a <> fregs.(0) then
        print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" fregs.(0) a) lnum_str
and g'_tail_if oc e1 e2 b bn lnum_str =
  let b_else = Id.genid (b ^ "_else") in
  print_new_line_with_loc oc (Printf.sprintf "\t%s\t%s" bn b_else) lnum_str;
  let stackset_back = !stackset in
  g oc (Tail, e1);
  print_new_line_with_loc oc (Printf.sprintf "%s:\t\t" b_else) lnum_str;
  stackset := stackset_back;
  g oc (Tail, e2)
and g'_non_tail_if oc dest e1 e2 b bn lnum_str =
  let b_else = Id.genid (b ^ "_else") in
  let b_cont = Id.genid (b ^ "_cont") in
  print_new_line_with_loc oc (Printf.sprintf "\t%s\t%s" bn b_else) lnum_str;
  let stackset_back = !stackset in
  g oc (dest, e1);
  let stackset1 = !stackset in
  print_new_line_with_loc oc (Printf.sprintf "\tjmp\t%s" b_cont) lnum_str;
  print_new_line_with_loc oc (Printf.sprintf "%s:\t\t" b_else) lnum_str;
  stackset := stackset_back;
  g oc (dest, e2);
  print_new_line_with_loc oc (Printf.sprintf "%s:\t\t" b_cont) lnum_str;
  let stackset2 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_args oc x_reg_cl ys zs lnum_str =
  assert (List.length ys <= Array.length regs - List.length x_reg_cl);
  assert (List.length zs <= Array.length fregs);
  let sw = Printf.sprintf "%d(%s)" (stacksize ()) reg_sp in
  let (i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> print_new_line_with_loc oc (Printf.sprintf "\tmovl\t%s, %s" y r) lnum_str)
    (shuffle sw yrs);
  let (d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> print_new_line_with_loc oc (Printf.sprintf "\tmovsd\t%s, %s" z fr) lnum_str)
    (shuffle sw zfrs)

let h oc { node = { name = Id.L(x); args = _; fargs = _; body = e; ret = _ }; loc } =
  let lnum_str = make_lnum_str loc in
  print_new_line_with_loc oc (Printf.sprintf "%s:\t\t" x ) lnum_str;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)

let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  Printf.fprintf oc ".data\n";
  Printf.fprintf oc ".balign\t8\n";
  List.iter
    (fun (Id.L(x), d) ->
      Printf.fprintf oc "%s:\t# %f\n" x d;
      Printf.fprintf oc "\t.long\t0x%lx\n" (gethi d);
      Printf.fprintf oc "\t.long\t0x%lx\n" (getlo d))
    data;
  Printf.fprintf oc ".text\n";
  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc ".globl\tmin_caml_start\n";
  Printf.fprintf oc "min_caml_start:\n";
  Printf.fprintf oc ".globl\t_min_caml_start\n";
  Printf.fprintf oc "_min_caml_start: # for cygwin\n";
  Printf.fprintf oc "\tpushl\t%%eax\n";
  Printf.fprintf oc "\tpushl\t%%ebx\n";
  Printf.fprintf oc "\tpushl\t%%ecx\n";
  Printf.fprintf oc "\tpushl\t%%edx\n";
  Printf.fprintf oc "\tpushl\t%%esi\n";
  Printf.fprintf oc "\tpushl\t%%edi\n";
  Printf.fprintf oc "\tpushl\t%%ebp\n";
  Printf.fprintf oc "\tmovl\t32(%%esp),%s\n" reg_sp;
  Printf.fprintf oc "\tmovl\t36(%%esp),%s\n" regs.(0);
  Printf.fprintf oc "\tmovl\t%s,%s\n" regs.(0) reg_hp;
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail(regs.(0)), e);
  Printf.fprintf oc "\tpopl\t%%ebp\n";
  Printf.fprintf oc "\tpopl\t%%edi\n";
  Printf.fprintf oc "\tpopl\t%%esi\n";
  Printf.fprintf oc "\tpopl\t%%edx\n";
  Printf.fprintf oc "\tpopl\t%%ecx\n";
  Printf.fprintf oc "\tpopl\t%%ebx\n";
  Printf.fprintf oc "\tpopl\t%%eax\n";
  Printf.fprintf oc "\tret\n";
