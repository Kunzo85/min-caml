(* Added!: Common Subexpression Elimination *)

open KNormal
open Location

let is_pure = function (* 純粋式。削除可能な式を表す *)
  | Unit | Int(_) | Float(_) | ExtArray(_)
  | Neg(_) | Add(_, _) | Sub(_, _) | Sll(_, _) | Sra(_, _) | FNeg(_) | FAdd(_, _) | FSub(_, _) | FMul(_, _) | FDiv(_, _)
  | Tuple(_) -> true
  | _ -> false

let comm_norm = function (* 交換法則に基づく正規化 *)
  | Add(x, y) when x > y -> Add(y, x)
  | FAdd(x, y) when x > y -> FAdd(y, x)
  | FMul(x, y) when x > y -> FMul(y, x)
  | e -> e

let replace_id repenv x = (* 変数の置き換え *)
  try M.find x repenv
  with Not_found -> x

let eliminate_expr exprenv e' = (* 共通部分式の削除 *)
  try
    let x = Hashtbl.find exprenv e' in
    Var(x)
  with Not_found -> e'

let create_exprenv () =
  Hashtbl.create 10

let rec g exprenv repenv e = (* 共通部分式削除ルーチン本体 *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Unit | Int(_) | Float(_) | ExtArray(_) as e' -> 
      inherit_loc (eliminate_expr exprenv e')
  | Neg(x) ->
      let x' = replace_id repenv x in
      let e' = Neg(x') in
      inherit_loc (eliminate_expr exprenv e')
  | Add(x, y) ->
      let x' = replace_id repenv x in
      let y' = replace_id repenv y in
      let e' = comm_norm (Add(x', y')) in
      inherit_loc (eliminate_expr exprenv e')
  | Sub(x, y) ->
      let x' = replace_id repenv x in
      let y' = replace_id repenv y in
      let e' = Sub(x', y') in
      inherit_loc (eliminate_expr exprenv e')
  | Sll(x, i) ->
      let x' = replace_id repenv x in
      let e' = Sll(x', i) in
      inherit_loc (eliminate_expr exprenv e')
  | Sra(x, i) ->
      let x' = replace_id repenv x in
      let e' = Sra(x', i) in
      inherit_loc (eliminate_expr exprenv e')
  | FNeg(x) ->
      let x' = replace_id repenv x in
      let e' = FNeg(x') in
      inherit_loc (eliminate_expr exprenv e')
  | FAdd(x, y) ->
      let x' = replace_id repenv x in
      let y' = replace_id repenv y in
      let e' = comm_norm (FAdd(x', y')) in
      inherit_loc (eliminate_expr exprenv e')
  | FSub(x, y) ->
      let x' = replace_id repenv x in
      let y' = replace_id repenv y in
      let e' = FSub(x', y') in
      inherit_loc (eliminate_expr exprenv e')
  | FMul(x, y) ->
      let x' = replace_id repenv x in
      let y' = replace_id repenv y in
      let e' = comm_norm (FMul(x', y')) in
      inherit_loc (eliminate_expr exprenv e')
  | FDiv(x, y) ->
      let x' = replace_id repenv x in
      let y' = replace_id repenv y in
      let e' = FDiv(x', y') in
      inherit_loc (eliminate_expr exprenv e')
  | IfEq(x, y, e1, e2) ->
      inherit_loc (IfEq(replace_id repenv x, replace_id repenv y, g (Hashtbl.copy exprenv) repenv e1, g (Hashtbl.copy exprenv) repenv e2))
  | IfLE(x, y, e1, e2) ->
      inherit_loc (IfLE(replace_id repenv x, replace_id repenv y, g (Hashtbl.copy exprenv) repenv e1, g (Hashtbl.copy exprenv) repenv e2))
  | Let((x, t), e1, e2) ->
      let e1' = g (Hashtbl.copy exprenv) repenv e1 in
      let e2' =
        let exprenv' = Hashtbl.copy exprenv in
        match e1'.node with
        | Var(y) -> g exprenv' (M.add x y repenv) e2
        | e' when is_pure e' ->
            Hashtbl.add exprenv' e' x;
            g exprenv' repenv e2
        | _ -> g exprenv' repenv e2 in
      inherit_loc (Let((x, t), e1', e2'))
  | Var(x) ->
      inherit_loc (Var(replace_id repenv x))
  | LetRec({ node = { name = xt; args = yts; body = e1 }; loc = fdloc}, e2) ->
      let e1' = g (create_exprenv ()) repenv e1 in
      let e2' = g (Hashtbl.copy exprenv) repenv e2 in
      inherit_loc (LetRec(make_wloc { name = xt; args = yts; body = e1' } fdloc, e2'))
  | App(g, xs) ->
      inherit_loc (App(replace_id repenv g, List.map (replace_id repenv) xs))
  | Tuple(xs) ->
      let xs' = List.map (replace_id repenv) xs in
      let e' = Tuple(xs') in
      inherit_loc (eliminate_expr exprenv e')
  | LetTuple(xts, y, e) ->
      inherit_loc (LetTuple(xts, replace_id repenv y, g (Hashtbl.copy exprenv) repenv e))
  | Get(x, y) ->
      inherit_loc (Get(replace_id repenv x, replace_id repenv y))
  | Put(x, y, z) ->
      inherit_loc (Put(replace_id repenv x, replace_id repenv y, replace_id repenv z))
  | ExtFunApp(x, ys) ->
      inherit_loc (ExtFunApp(x, List.map (replace_id repenv) ys))

let f filename e =
  print filename ".before_CSE" e; (* .alphaと同じになるよね..? *)
  Format.eprintf "Performing common subexpression elimination...@.";
  let e' = g (create_exprenv ()) M.empty e in
  print filename ".after_CSE" e';
  e'

let f_without_print e = (* 出力を行わずに共通部分式削除を実行。最適化に組み込む為 *)
  g (create_exprenv ()) M.empty e
  