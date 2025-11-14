(* Updated!: with_locに対応。 *)
(* β簡約 *)

open KNormal
open Location

let find x env = try M.find x env with Not_found -> x (* 置換のための関数 (caml2html: beta_find) *)

let rec g env e = (* β簡約ルーチン本体 (caml2html: beta_g) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Unit -> inherit_loc Unit
  | Int(i) -> inherit_loc (Int(i))
  | Float(d) -> inherit_loc (Float(d))
  | Neg(x) -> inherit_loc (Neg(find x env))
  | Add(x, y) -> inherit_loc (Add(find x env, find y env))
  | Sub(x, y) -> inherit_loc (Sub(find x env, find y env))
  | Sll(x, i) -> inherit_loc (Sll(find x env, i))
  | Sra(x, i) -> inherit_loc (Sra(find x env, i))
  | FNeg(x) -> inherit_loc (FNeg(find x env))
  | FAdd(x, y) -> inherit_loc (FAdd(find x env, find y env))
  | FSub(x, y) -> inherit_loc (FSub(find x env, find y env))
  | FMul(x, y) -> inherit_loc (FMul(find x env, find y env))
  | FDiv(x, y) -> inherit_loc (FDiv(find x env, find y env))
  | FAbs(x) -> inherit_loc (FAbs(find x env))
  | FSqrt(x) -> inherit_loc (FSqrt(find x env))
  | Floor(x) -> inherit_loc (Floor(find x env))
  | FloatToInt(x) -> inherit_loc (FloatToInt(find x env))
  | IntToFloat(x) -> inherit_loc (IntToFloat(find x env))
  | IfEq(x, y, e1, e2) -> inherit_loc (IfEq(find x env, find y env, g env e1, g env e2))
  | IfLE(x, y, e1, e2) -> inherit_loc (IfLE(find x env, find y env, g env e1, g env e2))
  | Let((x, t), e1, e2) -> (* letのβ簡約 (caml2html: beta_let) *)
      (match g env e1 with
      | { node = Var(y); _ } ->
          Format.eprintf "beta-reducing %s = %s@." x y;
          g (M.add x y env) e2
      | e1' ->
          let e2' = g env e2 in
          inherit_loc (Let((x, t), e1', e2')))
  | LetRec({ node = { name = xt; args = yts; body = e1 }; loc = fdloc}, e2) ->
      inherit_loc (LetRec(make_wloc { name = xt; args = yts; body = g env e1 } fdloc, g env e2))
  | Var(x) -> inherit_loc (Var(find x env)) (* 変数を置換 (caml2html: beta_var) *)
  | Tuple(xs) -> inherit_loc (Tuple(List.map (fun x -> find x env) xs))
  | LetTuple(xts, y, e) -> inherit_loc (LetTuple(xts, find y env, g env e))
  | Get(x, y) -> inherit_loc (Get(find x env, find y env))
  | Put(x, y, z) -> inherit_loc (Put(find x env, find y env, find z env))
  | App(g, xs) -> inherit_loc (App(find g env, List.map (fun x -> find x env) xs))
  | ExtArray(x) -> inherit_loc (ExtArray(x))
  | ExtFunApp(x, ys) -> inherit_loc (ExtFunApp(x, List.map (fun y -> find y env) ys))

let f = g M.empty
