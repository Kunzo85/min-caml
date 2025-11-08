(* Updated!: with_locに対応。 *)
(* 命令列の即値最適化 *)

open Asm
open Location

let rec g env = function (* 命令列の即値最適化 (caml2html: simm13_g) *)
  | Ans(exp) -> Ans(g' env exp)
  | Let((x, t), { node = Set(i); loc }, e) ->
      (* Format.eprintf "found simm %s = %d@." x i; *)
      let e' = g (M.add x i env) e in
      if List.mem x (fv e') then Let((x, t), make_wloc (Set(i)) loc, e') else
      ((* Format.eprintf "erased redundant Set to %s@." x; *)
       e')
  | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
and g' env e = (* 各命令の即値最適化 (caml2html: simm13_gprime) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Add(x, V(y)) when M.mem y env -> inherit_loc (Add(x, C(M.find y env)))
  | Add(x, V(y)) when M.mem x env -> inherit_loc (Add(y, C(M.find x env)))
  | Sub(x, V(y)) when M.mem y env -> inherit_loc (Sub(x, C(M.find y env)))
  | Ld(x, V(y), i) when M.mem y env -> inherit_loc (Ld(x, C(M.find y env), i))
  | St(x, y, V(z), i) when M.mem z env -> inherit_loc (St(x, y, C(M.find z env), i))
  | LdDF(x, V(y), i) when M.mem y env -> inherit_loc (LdDF(x, C(M.find y env), i))
  | StDF(x, y, V(z), i) when M.mem z env -> inherit_loc (StDF(x, y, C(M.find z env), i))
  | IfEq(x, V(y), e1, e2) when M.mem y env -> inherit_loc (IfEq(x, C(M.find y env), g env e1, g env e2))
  | IfLE(x, V(y), e1, e2) when M.mem y env -> inherit_loc (IfLE(x, C(M.find y env), g env e1, g env e2))
  | IfGE(x, V(y), e1, e2) when M.mem y env -> inherit_loc (IfGE(x, C(M.find y env), g env e1, g env e2))
  | IfEq(x, V(y), e1, e2) when M.mem x env -> inherit_loc (IfEq(y, C(M.find x env), g env e1, g env e2))
  | IfLE(x, V(y), e1, e2) when M.mem x env -> inherit_loc (IfGE(y, C(M.find x env), g env e1, g env e2))
  | IfGE(x, V(y), e1, e2) when M.mem x env -> inherit_loc (IfLE(y, C(M.find x env), g env e1, g env e2))
  | IfEq(x, y', e1, e2) -> inherit_loc (IfEq(x, y', g env e1, g env e2))
  | IfLE(x, y', e1, e2) -> inherit_loc (IfLE(x, y', g env e1, g env e2))
  | IfGE(x, y', e1, e2) -> inherit_loc (IfGE(x, y', g env e1, g env e2))
  | IfFEq(x, y, e1, e2) -> inherit_loc (IfFEq(x, y, g env e1, g env e2))
  | IfFLE(x, y, e1, e2) -> inherit_loc (IfFLE(x, y, g env e1, g env e2))
  | _ -> e

let h { node = { name = l; args = xs; fargs = ys; body = e; ret = t }; loc } = (* トップレベル関数の即値最適化 *)
  { node = { name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }; loc }

let f filename (Prog(data, fundefs, e)) = (* プログラム全体の即値最適化 *)
  Format.eprintf "Optimizing immediate values...@.";
  Prog(data, List.map h fundefs, g M.empty e)
