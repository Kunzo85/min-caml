(* Updated!: with_locに対応。 *)
(* 不要定義削除 *)

open KNormal
open Location

let rec pure e = (* 副作用の有無 (caml2html: elim_pure) *)
  match e.node with
  | Let(_, e1, e2) | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) -> pure e1 && pure e2
  | LetRec(_, e) | LetTuple(_, _, e) -> pure e
  | App _ | Put _ | ExtFunApp _ -> false
  | _ -> true

let rec f e = (* 不要定義削除ルーチン本体 (caml2html: elim_f) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | IfEq(x, y, e1, e2) -> inherit_loc (IfEq(x, y, f e1, f e2))
  | IfLE(x, y, e1, e2) -> inherit_loc (IfLE(x, y, f e1, f e2))
  | Let((x, t), e1, e2) -> (* letの場合 (caml2html: elim_let) *)
      let e1' = f e1 in
      let e2' = f e2 in
      if not (pure e1') || S.mem x (fv e2') then inherit_loc (Let((x, t), e1', e2')) else
      (Format.eprintf "eliminating variable %s@." x;
       e2')
  | LetRec({ node = { name = (x, t); args = yts; body = e1 }; loc = fdloc}, e2) -> (* let recの場合 (caml2html: elim_letrec) *)
      let e2' = f e2 in
      if S.mem x (fv e2') then
        inherit_loc (LetRec(make_wloc { name = (x, t); args = yts; body = f e1 } fdloc, e2'))
      else
        (Format.eprintf "eliminating function %s@." x;
         e2')
  | LetTuple(xts, y, e) ->
      let xs = List.map fst xts in
      let e' = f e in
      let live = fv e' in
      if List.exists (fun x -> S.mem x live) xs then inherit_loc (LetTuple(xts, y, e')) else
      (Format.eprintf "eliminating variables %s@." (Id.pp_list xs);
       e')
  | _ -> e
