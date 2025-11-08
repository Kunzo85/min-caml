(* i8v1/simm.ml *)

open Asm
open Location

let rec g env = function (* 命令列の16bit即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), { node = Li(i); loc }, e) when -32768 <= i && i < 32768 ->
      (* Format.eprintf "found simm16 %s = %d@." x i; *)
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then Let((x, t), { node = Li(i); loc }, e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  (* | Let(xt, Slw(y, C(i)), e) when M.mem y env -> (* for array access *)
      (* Format.eprintf "erased redundant Slw on %s@." x; *)
      g env (Let(xt, Li((M.find y env) lsl i), e)) *)
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
and g' env e = (* 各命令の16bit即値最適化 (caml2html: simm13_gprime) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Add(x, V(y)) when M.mem y env -> inherit_loc (Add(x, C(M.find y env)))
  | Add(x, V(y)) when M.mem x env -> inherit_loc (Add(y, C(M.find x env)))
  | Sub(x, y) when M.mem y env -> 
      let i = M.find y env in
      if -32768 < i && i <= 32768 then inherit_loc (Add(x, C(-i))) (* Subiはないので、Addiに変換 *)
      else e
  (* | Slw(x, V(y)) when M.mem y env -> Slw(x, C(M.find y env)) *)
  | Load(x, V(y)) when M.mem y env -> inherit_loc (Load(x, C(M.find y env)))
  | Store(x, y, V(z)) when M.mem z env -> inherit_loc (Store(x, y, C(M.find z env)))
  | FLoad(x, V(y)) when M.mem y env -> inherit_loc (FLoad(x, C(M.find y env)))
  | FStore(x, y, V(z)) when M.mem z env -> inherit_loc (FStore(x, y, C(M.find z env)))
  (* | IfEq(x, V(y), e1, e2) when M.mem y env -> IfEq(x, C(M.find y env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem y env -> IfLE(x, C(M.find y env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem y env -> IfGE(x, C(M.find y env), g env e1, g env e2)
  | IfEq(x, V(y), e1, e2) when M.mem x env -> IfEq(y, C(M.find x env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem x env -> IfGE(y, C(M.find x env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem x env -> IfLE(y, C(M.find x env), g env e1, g env e2) *) (* v1ではbranch命令しかないので、即値最適化はしない *)
  | IfEq(x, y, e1, e2) -> inherit_loc (IfEq(x, y, g env e1, g env e2))
  | IfLE(x, y, e1, e2) -> inherit_loc (IfLE(x, y, g env e1, g env e2))
  (* | IfGE(x, y, e1, e2) -> IfGE(x, y, g env e1, g env e2) *)
  | IfFEq(x, y, e1, e2) -> inherit_loc (IfFEq(x, y, g env e1, g env e2))
  | IfFLE(x, y, e1, e2) -> inherit_loc (IfFLE(x, y, g env e1, g env e2))
  | _ -> e

let h { node = { name = l; args = xs; fargs = ys; body = e; ret = t }; loc } = (* トップレベル関数の16bit即値最適化 *)
  { node = { name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }; loc }

let f filename (Prog(fundefs, e)) = (* プログラム全体の16bit即値最適化 *)
  let p = Prog(List.map h fundefs, g M.empty e) in
  print filename ".simm" p;
  p
