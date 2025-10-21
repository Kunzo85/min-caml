(* flatten let-bindings (just for prettier printing) *)

open KNormal
open Location

let rec f e = (* ネストしたletの簡約 (caml2html: assoc_f) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | IfEq(x, y, e1, e2) -> inherit_loc (IfEq(x, y, f e1, f e2))
  | IfLE(x, y, e1, e2) -> inherit_loc (IfLE(x, y, f e1, f e2))
  | Let(xt, e1, e2) -> (* letの場合 (caml2html: assoc_let) *)
      let rec insert e' = 
        match e'.node with
        | Let(yt, e3, e4) -> make_wloc (Let(yt, e3, insert e4)) e'.loc
        | LetRec(fundefs, e) -> make_wloc (LetRec(fundefs, insert e)) e'.loc
        | LetTuple(yts, z, e) -> make_wloc (LetTuple(yts, z, insert e)) e'.loc
        | _ -> inherit_loc (Let(xt, e', f e2)) in
      insert (f e1)
  | LetRec({ node = { name = xt; args = yts; body = e1 }; loc = fdloc}, e2) ->
      inherit_loc (LetRec(make_wloc { name = xt; args = yts; body = f e1 } fdloc, f e2))
  | LetTuple(xts, y, e) -> inherit_loc (LetTuple(xts, y, f e))
  | _ -> e
