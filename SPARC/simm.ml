open Asm
open Location

let rec g env = function (* 命令列の13bit即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> Ans(make_wloc (g' env exp.node) exp.loc)
  | Let(xt, exp, e) ->
      let inherit_loc node = make_wloc node exp.loc in
      (match exp.node with
      | Set(i) when -4096 <= i && i < 4096 ->
        (* Format.eprintf "found simm13 %s = %d@." x i; *)
        let (x, t) = xt in
        let e' = g (M.add x i env) e in
        if List.mem x (fv e') then Let((x, t), inherit_loc (Set(i)), e') else
        ((* Format.eprintf "erased redundant Set to %s@." x; *)
        e')
      | SLL(y, C(i)) when M.mem y env -> (* for array access *)
        (* Format.eprintf "erased redundant SLL on %s@." x; *)
        g env (Let(xt, inherit_loc (Set((M.find y env) lsl i)), e))
      | _ -> Let(xt, inherit_loc (g' env exp.node), g env e))
and g' env = function (* 各命令の13bit即値最適化 (caml2html: simm13_gprime) *)
  | Add(x, V(y)) when M.mem y env -> Add(x, C(M.find y env))
  | Add(x, V(y)) when M.mem x env -> Add(y, C(M.find x env))
  | Sub(x, V(y)) when M.mem y env -> Sub(x, C(M.find y env))
  | SLL(x, V(y)) when M.mem y env -> SLL(x, C(M.find y env))
  | Ld(x, V(y)) when M.mem y env -> Ld(x, C(M.find y env))
  | St(x, y, V(z)) when M.mem z env -> St(x, y, C(M.find z env))
  | LdDF(x, V(y)) when M.mem y env -> LdDF(x, C(M.find y env))
  | StDF(x, y, V(z)) when M.mem z env -> StDF(x, y, C(M.find z env))
  | IfEq(x, V(y), e1, e2) when M.mem y env -> IfEq(x, C(M.find y env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem y env -> IfLE(x, C(M.find y env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem y env -> IfGE(x, C(M.find y env), g env e1, g env e2)
  | IfEq(x, V(y), e1, e2) when M.mem x env -> IfEq(y, C(M.find x env), g env e1, g env e2)
  | IfLE(x, V(y), e1, e2) when M.mem x env -> IfGE(y, C(M.find x env), g env e1, g env e2)
  | IfGE(x, V(y), e1, e2) when M.mem x env -> IfLE(y, C(M.find x env), g env e1, g env e2)
  | IfEq(x, y', e1, e2) -> IfEq(x, y', g env e1, g env e2)
  | IfLE(x, y', e1, e2) -> IfLE(x, y', g env e1, g env e2)
  | IfGE(x, y', e1, e2) -> IfGE(x, y', g env e1, g env e2)
  | IfFEq(x, y, e1, e2) -> IfFEq(x, y, g env e1, g env e2)
  | IfFLE(x, y, e1, e2) -> IfFLE(x, y, g env e1, g env e2)
  | e -> e

let h { node = { name = l; args = xs; fargs = ys; body = e; ret = t }; loc } = (* トップレベル関数の13bit即値最適化 *)
  { node = { name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }; loc }

let f (Prog(data, fundefs, e)) = (* プログラム全体の13bit即値最適化 *)
  Prog(data, List.map h fundefs, g M.empty e)
