open Asm
open Location
open Lexing

(* external gethi : float -> int32 = "gethi"
external getlo : float -> int32 = "getlo" *)

let tab = "    "
let print_inst oc inst args loc =
  let inst_str = Printf.sprintf "%s%-5s%s%s" tab inst tab (String.concat "  " args) in
  Printf.fprintf oc "%-43s%s%d\n" inst_str ("# !") loc.start_pos.pos_lnum
(* let print_inst oc inst args loc = (* 引数間のスペースを1にする用 *)
  let inst_str = Printf.sprintf "%s%s%s%s" tab inst " " (String.concat " " args) in
  Printf.fprintf oc "%-43s%s%d\n" inst_str ("# !") loc.start_pos.pos_lnum *)

(* let print_inst oc inst args loc comment =
  Printf.fprintf oc "%s%s%s%s%s%d%s# %s\n" tab inst tab (String.concat " " args) (tab ^ tab ^ "# !") loc.Lexing.start_pos.Lexing.pos_lnum (tab ^ tab) comment *)

let print_comment oc s =
  Printf.fprintf oc "%s# %s\n" tab s

let print_block_comment oc ss with_tab =
  let tab = if with_tab then tab else "" in
  Printf.fprintf oc "%s++\n" tab;
  List.iter (fun s -> Printf.fprintf oc "%s%s\n" tab s) ss;
  Printf.fprintf oc "%s++\n" tab

let copy_file_to_channel oc filename =
  In_channel.with_open_text filename (fun ic ->
    let content = In_channel.input_all ic in
    Out_channel.output_string oc content)

let divide_imm i32 =
  let high = Int32.shift_right i32 21 in
  let low = Int32.logand i32 0x1fffffl in
  let low = if low >= 0x100000l then Int32.logor low 0xffe00000l else low in
  (high, low)

let int32_to_bitstring x =
  let buf = Bytes.create 32 in
  for i = 0 to 31 do
    let bit = Int32.(logand (shift_right_logical x (31 - i)) 1l) in
    Bytes.set buf i (if bit = 1l then '1' else '0')
  done;
  Bytes.unsafe_to_string buf

let abs_label l = "~" ^ l

let stackset = ref S.empty (* すでにSaveされた変数の集合 (caml2html: emit_stackset) *)

let stackmap = ref [] (* Saveされた変数の、スタックにおける位置 (caml2html: emit_stackmap) *)

type int_or_float = IntType | FloatType
let tyenv = ref M.empty (* 変数の型環境 *)

let save x t =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    stackmap := !stackmap @ [x];
    tyenv := M.add x t !tyenv

(* let savef x =
  stackset := S.add x !stackset;
  if not (List.mem x !stackmap) then
    (let pad =
      if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in
    stackmap := !stackmap @ pad @ [x; x]) *)

let locate x =
  let rec loc = function
    | [] -> []
    | y :: zs when x = y -> 0 :: List.map succ (loc zs)
    | _y :: zs -> List.map succ (loc zs) in
  loc !stackmap

let offset x = List.hd (locate x)

let stacksize () = List.length !stackmap + 1 (* この+1は何のため？->これから入れる戻りアドレスの分かな？ *)

(* let reg r =
  if is_reg r
  then String.sub r 1 (String.length r - 1)
  else r *)

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
  | dest, Let((x, _t), exp, e) ->
      g' oc (NonTail(x), exp);
      g oc (dest, e)
and g' oc (dest, e) = (* 各命令のアセンブリ生成 (caml2html: emit_gprime) *)
  (* 末尾でなかったら計算結果をdestにセット (caml2html: emit_nontail) *)
  match dest, e.node with
  | NonTail(_), Nop -> ()
  | NonTail(x), Li(i) when fit_in_signed 16 i -> print_inst oc "addi" [x; reg_zero; string_of_int i] e.loc (* 符号拡張してほしいのでliではなくaddiを使う *)
  | NonTail(x), Li(i) -> (* iが16bitで表せないとき *)
      let bits = Int32.of_int i in
      let h, l = divide_imm bits in
      print_inst oc "li" [x; Int32.to_string l] e.loc;
      print_inst oc "lui" [x; Int32.to_string h] e.loc;
      print_block_comment oc [
        Printf.sprintf "li %d" i;
        Printf.sprintf "=> li  %s 0b%s" x (String.sub (int32_to_bitstring l) 11 21);
        Printf.sprintf "   lui %s 0b%s" x (String.sub (int32_to_bitstring h) 21 11);
      ] true
  | NonTail(x), FLi(f) ->
      let bits = Int32.bits_of_float f in
      let h, l = divide_imm bits in
      print_inst oc "fli" [x; Int32.to_string l] e.loc;
      print_inst oc "flui" [x; Int32.to_string h] e.loc;
      print_block_comment oc [
        Printf.sprintf "fli %f" f;
        Printf.sprintf "=> fli  %s 0b%s" x (String.sub (int32_to_bitstring l) 11 21);
        Printf.sprintf "   flui %s 0b%s" x (String.sub (int32_to_bitstring h) 21 11);
      ] true
  | NonTail(x), SetL(Id.L(y)) ->
      print_inst oc "setl" [x; abs_label y] e.loc
  | NonTail(x), Mr(y) when x = y -> ()
  | NonTail(x), Mr(y) -> print_inst oc "movz" [x; y; reg_zero] e.loc
  | NonTail(x), Add(y, V(z)) -> print_inst oc "add" [x; y; z] e.loc
  | NonTail(x), Add(y, C(z)) -> assert (fit_in_signed 16 z); print_inst oc "addi" [x; y; string_of_int z] e.loc
  | NonTail(x), Sub(y, z) -> print_inst oc "sub" [x; y; z] e.loc
  | NonTail(x), Sll(y, i) -> assert (0 <= i && i < 32); print_inst oc "sll" [x; y; string_of_int i] e.loc
  | NonTail(x), Sra(y, i) -> assert (0 <= i && i < 32); print_inst oc "sra" [x; y; string_of_int i] e.loc
  | NonTail(x), Load(y, V(z)) -> print_inst oc "lwv" [x; y; z] e.loc
  | NonTail(x), Load(y, C(z)) -> assert (fit_in_signed 16 z); print_inst oc "lw" [x; y; string_of_int z] e.loc
  | NonTail(_), Store(x, y, V(z)) -> print_inst oc "swv" [x; y; z] e.loc
  | NonTail(_), Store(x, y, C(z)) -> assert (fit_in_signed 16 z); print_inst oc "sw" [x; y; string_of_int z] e.loc
  | NonTail(x), FMr(y) when x = y -> ()
  | NonTail(x), FMr(y) -> print_inst oc "fmovz" [x; y; reg_zero] e.loc
  | NonTail(x), FNeg(y) -> print_inst oc "fneg" [x; y] e.loc
  | NonTail(x), FAdd(y, z) -> print_inst oc "fadd" [x; y; z] e.loc
  | NonTail(x), FSub(y, z) -> print_inst oc "fsub" [x; y; z] e.loc
  | NonTail(x), FMul(y, z) -> print_inst oc "fmul" [x; y; z] e.loc
  | NonTail(x), FDiv(y, z) -> print_inst oc "fdiv" [x; y; z] e.loc
  | NonTail(x), FAbs(y) -> print_inst oc "fabs" [x; y] e.loc
  | NonTail(x), FSqrt(y) -> print_inst oc "fsqrt" [x; y] e.loc
  | NonTail(x), Floor(y) -> print_inst oc "floor" [x; y] e.loc
  | NonTail(x), FloatToInt(y) -> print_inst oc "ftoi" [x; y] e.loc
  | NonTail(x), IntToFloat(y) -> print_inst oc "itof" [x; y] e.loc
  | NonTail(x), FLoad(y, V(z)) -> print_inst oc "flwv" [x; y; z] e.loc
  | NonTail(x), FLoad(y, C(z)) -> assert (fit_in_signed 16 z); print_inst oc "flw" [x; y; string_of_int z] e.loc
  | NonTail(_), FStore(x, y, V(z)) -> print_inst oc "fswv" [x; y; z] e.loc
  | NonTail(_), FStore(x, y, C(z)) -> assert (fit_in_signed 16 z); print_inst oc "fsw" [x; y; string_of_int z] e.loc
  | NonTail(_), Comment(s) -> print_comment oc s
  (* 退避の仮想命令の実装 (caml2html: emit_save) *)
  | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) ->
      save y IntType;
      print_inst oc "sw" [x; reg_sp; string_of_int (- (offset y))] e.loc
  | NonTail(_), Save(x, y) when List.mem x allfregs && not (S.mem y !stackset) ->
      save y FloatType;
      print_inst oc "fsw" [x; reg_sp; string_of_int (- (offset y))] e.loc
  | NonTail(_), Save(_x, y) -> assert (S.mem y !stackset); () (* α変換済みなので、同じ名前の変数が退避されていたらOK *)
  (* 復帰の仮想命令の実装 (caml2html: emit_restore) *)
  | NonTail(x), Restore(y) when List.mem x allregs ->
      print_inst oc "lw" [x; reg_sp; string_of_int (- (offset y))] e.loc
  | NonTail(x), Restore(y) ->
      assert (List.mem x allfregs);
      print_inst oc "flw" [x; reg_sp; string_of_int (- (offset y))] e.loc
  (* 末尾だったら計算結果を第一レジスタにセットしてリターン (caml2html: emit_tailret) *)
  | Tail, (Nop | Store _ | FStore _ | Comment _ | Save _) ->
      g' oc (NonTail(Id.gentmp Type.Unit), e);
      print_inst oc "jr" [reg_ra] e.loc
  | Tail, (Li _ | SetL _ | Mr _ | Add _ | Sub _ | Sll _ | Sra _ | FloatToInt _ | Load _) ->
      g' oc (NonTail(regs.(0)), e);
      print_inst oc "jr" [reg_ra] e.loc
  | Tail, (FLi _ | FMr _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ | FAbs _ | FSqrt _ | Floor _ | IntToFloat _ | FLoad _) ->
      g' oc (NonTail(fregs.(0)), e);
      print_inst oc "jr" [reg_ra] e.loc
  | Tail, (Restore(x)) ->
      (* let i = locate x in *)
      (match M.find x !tyenv with
      | IntType ->
          g' oc (NonTail(regs.(0)), e)
      | FloatType ->
          g' oc (NonTail(fregs.(0)), e));
      print_inst oc "jr" [reg_ra] e.loc
  | Tail, IfEq(x, y, e1, e2) ->
      g'_tail_if oc x y e1 e2 "beq" e.loc
  | Tail, IfLE(x, y, e1, e2) ->
      g'_tail_if oc y x e2 e1 "blt" e.loc (* ニーモニックにはbltしかないのでここで調整。Virtualで気づくべきだった *)
  | Tail, IfFEq(x, y, e1, e2) ->
      g'_tail_if oc x y e1 e2 "fbeq" e.loc
  | Tail, IfFLE(x, y, e1, e2) ->
      g'_tail_if oc y x e2 e1 "fblt" e.loc
  | NonTail(z), IfEq(x, y, e1, e2) ->
      g'_non_tail_if oc (NonTail(z)) x y e1 e2 "beq" e.loc
  | NonTail(z), IfLE(x, y, e1, e2) ->
      g'_non_tail_if oc (NonTail(z)) y x e2 e1 "blt" e.loc
  | NonTail(z), IfFEq(x, y, e1, e2) ->
      g'_non_tail_if oc (NonTail(z)) x y e1 e2 "fbeq" e.loc
  | NonTail(z), IfFLE(x, y, e1, e2) ->
      g'_non_tail_if oc (NonTail(z)) y x e2 e1 "fblt" e.loc
  (* 関数呼び出しの仮想命令の実装 (caml2html: emit_call) *)
  | Tail, CallCls(x, ys, zs) -> (* 末尾呼び出し (caml2html: emit_tailcall) *)
      g'_args oc [(x, reg_cl)] ys zs e.loc;
      print_inst oc "lw" [reg_sw; reg_cl; "0"] e.loc;
      print_inst oc "jr" [reg_sw] e.loc
  | Tail, CallDir(Id.L(x), ys, zs) -> (* 末尾呼び出し *)
      g'_args oc [] ys zs e.loc;
      (* Printf.fprintf oc "\tb\t%s\n" x *)
      print_inst oc "j" [abs_label x] e.loc;
  | NonTail(a), CallCls(x, ys, zs) ->
      (* Printf.fprintf oc "\tmflr\t%s\n" (reg reg_tmp); *)
      g'_args oc [(x, reg_cl)] ys zs e.loc;
      let ss = stacksize () in
      (* Printf.fprintf oc "\tstw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tlwz\t%s, 0(%s)\n" (reg reg_tmp) (reg reg_cl);
      Printf.fprintf oc "\tmtctr\t%s\n" (reg reg_tmp);
      Printf.fprintf oc "\tbctrl\n";
      Printf.fprintf oc "\tsubi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tlwz\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp); *)
      assert (fit_in_signed 16 ss);
      print_inst oc "sw" [reg_ra; reg_sp; string_of_int (- (ss - 1))] e.loc;
      print_inst oc "addi" [reg_sp; reg_sp; string_of_int (-ss)] e.loc;
      print_inst oc "lw" [reg_sw; reg_cl; "0"] e.loc;
      print_inst oc "jalr" [reg_sw] e.loc;
      print_inst oc "addi" [reg_sp; reg_sp; string_of_int ss] e.loc;
      print_inst oc "lw" [reg_ra; reg_sp; string_of_int (- (ss - 1))] e.loc;
      if List.mem a allregs && a <> regs.(0) then
        (* Printf.fprintf oc "\tmr\t%s, %s\n" (reg a) (reg regs.(0)) *)
        print_inst oc "movz" [a; regs.(0); reg_zero] e.loc
      else if List.mem a allfregs && a <> fregs.(0) then
        (* Printf.fprintf oc "\tfmr\t%s, %s\n" (reg a) (reg fregs.(0)); *)
        print_inst oc "fmovz" [a; fregs.(0); reg_zero] e.loc;
      (* Printf.fprintf oc "\tmtlr\t%s\n" (reg reg_tmp) *)
  | (NonTail(a), CallDir(Id.L(x), ys, zs)) ->
      (* Printf.fprintf oc "\tmflr\t%s\n" (reg reg_tmp); *)
      g'_args oc [] ys zs e.loc;
      let ss = stacksize () in
      (* Printf.fprintf oc "\tstw\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp);
      Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tbl\t%s\n" x;
      Printf.fprintf oc "\tsubi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
      Printf.fprintf oc "\tlwz\t%s, %d(%s)\n" (reg reg_tmp) (ss - 4) (reg reg_sp); *)
      assert (fit_in_signed 16 ss);
      print_inst oc "sw" [reg_ra; reg_sp; string_of_int (- (ss - 1))] e.loc;
      print_inst oc "addi" [reg_sp; reg_sp; string_of_int (-ss)] e.loc;
      print_inst oc "jal" [abs_label x] e.loc;
      print_inst oc "addi" [reg_sp; reg_sp; string_of_int ss] e.loc;
      print_inst oc "lw" [reg_ra; reg_sp; string_of_int (- (ss - 1))] e.loc;
      if List.mem a allregs && a <> regs.(0) then
        (* Printf.fprintf oc "\tmr\t%s, %s\n" (reg a) (reg regs.(0)) *)
        print_inst oc "movz" [a; regs.(0); reg_zero] e.loc
      else if List.mem a allfregs && a <> fregs.(0) then
        (* Printf.fprintf oc "\tfmr\t%s, %s\n" (reg a) (reg fregs.(0)); *)
        print_inst oc "fmovz" [a; fregs.(0); reg_zero] e.loc;
      (* Printf.fprintf oc "\tmtlr\t%s\n" (reg reg_tmp) *)
and g'_tail_if oc x y e1 e2 b loc =
  let b_then = Id.genid (b ^ "_then") in
  (* Printf.fprintf oc "\t%s\tcr7, %s\n" bn b_else; *)
  print_inst oc b [x; y; b_then] loc;
  let stackset_back = !stackset in (* stackmapはバックアップを取らないことに注意。then用、else用のスタック領域は予め静的に確保する。 *)
  g oc (Tail, e2);
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (Tail, e1)
and g'_non_tail_if oc dest x y e1 e2 b loc = (* destにはNonTailしか渡されない *)
  let b_then = Id.genid (b ^ "_then") in
  let b_cont = Id.genid (b ^ "_cont") in
  (* Printf.fprintf oc "\t%s\tcr7, %s\n" bn b_else; *)
  print_inst oc b [x; y; b_then] loc;
  let stackset_back = !stackset in
  g oc (dest, e2);
  let stackset2 = !stackset in
  (* Printf.fprintf oc "\tb\t%s\n" b_cont; *)
  print_inst oc "j" [abs_label b_cont] loc;
  Printf.fprintf oc "%s:\n" b_then;
  stackset := stackset_back;
  g oc (dest, e1);
  Printf.fprintf oc "%s:\n" b_cont;
  let stackset1 = !stackset in
  stackset := S.inter stackset1 stackset2
and g'_args oc x_reg_cl ys zs loc =
  let (_i, yrs) =
    List.fold_left
      (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
      (0, x_reg_cl)
      ys in
  List.iter
    (fun (y, r) -> print_inst oc "movz" [r; y; reg_zero] loc)
    (shuffle reg_sw yrs);
  let (_d, zfrs) =
    List.fold_left
      (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
      (0, [])
      zs in
  List.iter
    (fun (z, fr) -> print_inst oc "fmovz" [fr; z; reg_zero] loc)
    (shuffle reg_fsw zfrs)

let h oc { node = { name = Id.L(x); args = _; fargs = _; body = e; ret = _ }; _ } =
  Printf.fprintf oc "%s:\n" x;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)

let f oc linked_libraries (Prog(fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  print_block_comment oc [
    "Assembly code generated by MinCaml modified by Yuya Tanaka. ";
    "Target machine: I8 version 1";
    "THIS IS MAIN ENTRY POINT!";
  ] false;
  (* Printf.fprintf oc "_min_caml_start: # main entry point\n";
  Printf.fprintf oc "\tmflr\tr0\n";
  Printf.fprintf oc "\tstmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tstw\tr0, 8(r1)\n";
  Printf.fprintf oc "\tstwu\tr1, -96(r1)\n";
  Printf.fprintf oc "#\tmain program starts\n"; *)
  Printf.fprintf oc "min_caml_start:\n";
  (* 何かしたほうがいいのかな・・必要性を認識したら書きます。 *)
  (* let e = Let ((reg_sp, Type.Int), Li(0), e) in
  let e = Let ((reg_hp, Type.Int), Li(0x01B00000), e) in *)
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail(regs.(0)), e);
  (* Printf.fprintf oc "#\tmain program ends\n"; *)
  (* Printf.fprintf oc "\tmr\tr3, %s\n" regs.(0); *)
  (* Printf.fprintf oc "\tlwz\tr1, 0(r1)\n";
  Printf.fprintf oc "\tlwz\tr0, 8(r1)\n";
  Printf.fprintf oc "\tmtlr\tr0\n";
  Printf.fprintf oc "\tlmw\tr30, -8(r1)\n";
  Printf.fprintf oc "\tblr\n" *)
  print_inst oc "j" [abs_label "inf_loop"] (ghost_loc ());
  Printf.fprintf oc "%s:\n" "inf_loop";
  print_inst oc "j" [abs_label "inf_loop"] (ghost_loc ());
  Printf.fprintf oc "\n";
  print_block_comment oc [
    "These are function definitions."
  ] false;
  List.iter (fun fundef -> h oc fundef) fundefs;
  List.iter (fun f -> copy_file_to_channel oc (f ^ ".s")) linked_libraries;
  ()
