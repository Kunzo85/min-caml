open Location

type closure = { entry : Id.l; actual_fv : Id.t list }
type t' = (* クロージャ変換後の式 (caml2html: closure_t) *)
  | Unit
  | Int of int
  | Float of float
  | Neg of Id.t
  | Add of Id.t * Id.t
  | Sub of Id.t * Id.t
  | FNeg of Id.t
  | FAdd of Id.t * Id.t
  | FSub of Id.t * Id.t
  | FMul of Id.t * Id.t
  | FDiv of Id.t * Id.t
  | IfEq of Id.t * Id.t * t * t
  | IfLE of Id.t * Id.t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | MakeCls of (Id.t * Type.t) * closure * t
  | AppCls of Id.t * Id.t list
  | AppDir of Id.l * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.l
and t = t' with_loc

type fundef' = { name : Id.l * Type.t;
                args : (Id.t * Type.t) list;
                formal_fv : (Id.t * Type.t) list;
                body : t }
type fundef = fundef' with_loc

type prog = Prog of fundef list * t

let rec fv e =
  match e.node with
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) -> S.singleton x
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2)| IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | MakeCls((x, t), { entry = l; actual_fv = ys }, e) -> S.remove x (S.union (S.of_list ys) (fv e))
  | AppCls(x, ys) -> S.of_list (x :: ys)
  | AppDir(_, xs) | Tuple(xs) -> S.of_list xs
  | LetTuple(xts, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xts)))
  | Put(x, y, z) -> S.of_list [x; y; z]

let toplevel : fundef list ref = ref []

let rec g env known e = (* クロージャ変換ルーチン本体 (caml2html: closure_g) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | KNormal.Unit -> inherit_loc Unit
  | KNormal.Int(i) -> inherit_loc (Int(i))
  | KNormal.Float(d) -> inherit_loc (Float(d))
  | KNormal.Neg(x) -> inherit_loc (Neg(x))
  | KNormal.Add(x, y) -> inherit_loc (Add(x, y))
  | KNormal.Sub(x, y) -> inherit_loc (Sub(x, y))
  | KNormal.FNeg(x) -> inherit_loc (FNeg(x))
  | KNormal.FAdd(x, y) -> inherit_loc (FAdd(x, y))
  | KNormal.FSub(x, y) -> inherit_loc (FSub(x, y))
  | KNormal.FMul(x, y) -> inherit_loc (FMul(x, y))
  | KNormal.FDiv(x, y) -> inherit_loc (FDiv(x, y))
  | KNormal.IfEq(x, y, e1, e2) -> inherit_loc (IfEq(x, y, g env known e1, g env known e2))
  | KNormal.IfLE(x, y, e1, e2) -> inherit_loc (IfLE(x, y, g env known e1, g env known e2))
  | KNormal.Let((x, t), e1, e2) -> inherit_loc (Let((x, t), g env known e1, g (M.add x t env) known e2))
  | KNormal.Var(x) -> inherit_loc (Var(x))
  | KNormal.LetRec({node = { KNormal.name = (x, t); KNormal.args = yts; KNormal.body = e1 }; loc = fdloc}, e2) -> (* 関数定義の場合 (caml2html: closure_letrec) *)
      (* 関数定義let rec x y1 ... yn = e1 in e2の場合は、
         xに自由変数がない(closureを介さずdirectに呼び出せる)
         と仮定し、knownに追加してe1をクロージャ変換してみる *)
      (* knownはdirectに呼び出せる関数?(closureではない) *)
      let toplevel_backup = !toplevel in
      let env' = M.add x t env in
      let known' = S.add x known in
      let e1' = g (M.add_list yts env') known' e1 in
      (* 本当に自由変数がなかったか、変換結果e1'を確認する *)
      (* 注意: e1'にx自身が変数として出現する場合はclosureが必要!
         (thanks to nuevo-namasute and azounoman; test/cls-bug2.ml参照) *)
      let zs = S.diff (fv e1') (S.of_list (List.map fst yts)) in
      let known', e1' =
        if S.is_empty zs then known', e1' else
        (* 駄目だったら状態(toplevelの値)を戻して、クロージャ変換をやり直す *)
        (Format.eprintf "free variable(s) %s found in function %s@." (Id.pp_list (S.elements zs)) x;
         Format.eprintf "function %s cannot be directly applied in fact@." x;
         toplevel := toplevel_backup;
         let e1' = g (M.add_list yts env') known e1 in
         known, e1') in 
      let zs = S.elements (S.diff (fv e1') (S.add x (S.of_list (List.map fst yts)))) in (* 自由変数のリスト *)
      let zts = List.map (fun z -> (z, M.find z env')) zs in (* ここで自由変数zの型を引くために引数envが必要 *)
      toplevel := (make_wloc { name = (Id.L(x), t); args = yts; formal_fv = zts; body = e1' } fdloc) :: !toplevel; (* トップレベル関数を追加 *)
      let e2' = g env' known' e2 in
      if S.mem x (fv e2') then (* xが変数としてe2'に出現するか *)
        inherit_loc (MakeCls((x, t), { entry = Id.L(x); actual_fv = zs }, e2')) (* 出現していたら削除しない *)
      else
        (Format.eprintf "eliminating closure(s) %s@." x;
         e2') (* 出現しなければMakeClsを削除 *)
  | KNormal.App(x, ys) when S.mem x known -> (* 関数適用の場合 (caml2html: closure_app) *)
      Format.eprintf "directly applying %s@." x;
      inherit_loc (AppDir(Id.L(x), ys))
  | KNormal.App(f, xs) -> inherit_loc (AppCls(f, xs))
  | KNormal.Tuple(xs) -> inherit_loc (Tuple(xs))
  | KNormal.LetTuple(xts, y, e) -> inherit_loc (LetTuple(xts, y, g (M.add_list xts env) known e))
  | KNormal.Get(x, y) -> inherit_loc (Get(x, y))
  | KNormal.Put(x, y, z) -> inherit_loc (Put(x, y, z))
  | KNormal.ExtArray(x) -> inherit_loc (ExtArray(Id.L(x)))
  | KNormal.ExtFunApp(x, ys) -> inherit_loc (AppDir(Id.L("min_caml_" ^ x), ys))

let f e =
  Format.eprintf "Converting to closure form...@.";
  toplevel := [];
  let e' = g M.empty S.empty e in
  Prog(List.rev !toplevel, e')
