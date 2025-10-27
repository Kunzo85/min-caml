(* Common Subexpression Elimination *)

open KNormal
open Location

let comm_norm = function
  | Add(x, y) when x > y -> Add(y, x)
  | FAdd(x, y) when x > y -> FAdd(y, x)
  | FMul(x, y) when x > y -> FMul(y, x)
  | e -> e

let replace repenv x =
  try M.find x repenv
  with Not_found -> x

let eliminate exprenv e' inherit_loc =
  try
    let x = Hashtbl.find exprenv e' in
    inherit_loc (Var(x))
  with Not_found -> inherit_loc e'

let create_exprenv () =
  Hashtbl.create 10

let rec g exprenv repenv e =
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Unit | Int(_) | Float(_) | ExtArray(_) -> e
  | Neg(x) ->
      let x' = replace repenv x in
      let e' = Neg(x') in
      eliminate exprenv e' inherit_loc
  | Add(x, y) ->
      let x' = replace repenv x in
      let y' = replace repenv y in
      let e' = comm_norm (Add(x', y')) in
      eliminate exprenv e' inherit_loc
  | Sub(x, y) ->
      let x' = replace repenv x in
      let y' = replace repenv y in
      let e' = Sub(x', y') in
      eliminate exprenv e' inherit_loc
  | FNeg(x) ->
      let x' = replace repenv x in
      let e' = FNeg(x') in
      eliminate exprenv e' inherit_loc
  | FAdd(x, y) ->
      let x' = replace repenv x in
      let y' = replace repenv y in
      let e' = comm_norm (FAdd(x', y')) in
      eliminate exprenv e' inherit_loc
  | FSub(x, y) ->
      let x' = replace repenv x in
      let y' = replace repenv y in
      let e' = FSub(x', y') in
      eliminate exprenv e' inherit_loc
  | FMul(x, y) ->
      let x' = replace repenv x in
      let y' = replace repenv y in
      let e' = comm_norm (FMul(x', y')) in
      eliminate exprenv e' inherit_loc
  | FDiv(x, y) ->
      let x' = replace repenv x in
      let y' = replace repenv y in
      let e' = FDiv(x', y') in
      eliminate exprenv e' inherit_loc
  | IfEq(x, y, e1, e2) ->
      inherit_loc (IfEq(replace repenv x, replace repenv y, g (Hashtbl.copy exprenv) repenv e1, g (Hashtbl.copy exprenv) repenv e2))
  | IfLE(x, y, e1, e2) ->
      inherit_loc (IfLE(replace repenv x, replace repenv y, g (Hashtbl.copy exprenv) repenv e1, g (Hashtbl.copy exprenv) repenv e2))
  | Let((x, t), e1, e2) ->
      let e1' = g (Hashtbl.copy exprenv) repenv e1 in
      let e2' =
        let exprenv' = Hashtbl.copy exprenv in
      match e1'.node with
      | Var(y) -> g exprenv' (M.add x y repenv) e2
      | Neg(_) | Add(_, _) | Sub(_, _) | FNeg(_) | FAdd(_, _) | FSub(_, _) | FMul(_, _) | FDiv(_, _) | Tuple(_) as kn ->
          Hashtbl.add exprenv' kn x;
          g exprenv' repenv e2
      | _ -> g exprenv' repenv e2 in
      inherit_loc (Let((x, t), e1', e2'))
  | Var(x) ->
      inherit_loc (Var(replace repenv x))
  | LetRec({ node = { name = xt; args = yts; body = e1 }; loc = fdloc}, e2) ->
      let e1' = g (create_exprenv ()) repenv e1 in
      let e2' = g (Hashtbl.copy exprenv) repenv e2 in
      inherit_loc (LetRec(make_wloc { name = xt; args = yts; body = e1' } fdloc, e2'))
  | App(g, xs) ->
      inherit_loc (App(replace repenv g, List.map (replace repenv) xs))
  | Tuple(xs) ->
      let xs' = List.map (replace repenv) xs in
      let e' = Tuple(xs') in
      eliminate exprenv e' inherit_loc
  | LetTuple(xts, y, e) ->
      inherit_loc (LetTuple(xts, replace repenv y, g (Hashtbl.copy exprenv) repenv e))
  | Get(x, y) ->
      inherit_loc (Get(replace repenv x, replace repenv y))
  | Put(x, y, z) ->
      inherit_loc (Put(replace repenv x, replace repenv y, replace repenv z))
  | ExtFunApp(x, ys) ->
      inherit_loc (ExtFunApp(x, List.map (replace repenv) ys))

let f filename e =
  print filename ".before_CSE" e; (* .alphaと同じになるよね..? *)
  Format.eprintf "Performing common subexpression elimination...@.";
  let e' = g (create_exprenv ()) M.empty e in
  print filename ".after_CSE" e';
  e'
  