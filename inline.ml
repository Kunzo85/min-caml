open KNormal
open Location

(* インライン展開する関数の最大サイズ (caml2html: inline_threshold) *)
let threshold = ref 0 (* Mainで-inlineオプションによりセットされる *)

let rec size = function (* 関数の大きさを測る (caml2html: inline_size) *)
  | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) -> 1 + size e1.node + size e2.node
  | Let(_, e1, e2) -> 1 + size e1.node + size e2.node
  | LetRec({ node = { name; args; body = e1 }; _}, e2) -> 1 + size e1.node + size e2.node
  | LetTuple(_, _, e) -> 1 + size e.node
  | _ -> 1

let rec g env = function (* インライン展開ルーチン本体 (caml2html: inline_g) *)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, h env e1, h env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, h env e1, h env e2)
  | Let(xt, e1, e2) -> Let(xt, h env e1, h env e2)
  | LetRec({ node = { name = (x, t); args = yts; body = e1 }; loc = fdloc}, e2) -> (* 関数定義の場合 (caml2html: inline_letrec) *)
      let env = if size e1.node > !threshold then env else M.add x (yts, e1) env in
      LetRec(make_wloc { name = (x, t); args = yts; body = h env e1} fdloc, h env e2)
  | App(x, ys) when M.mem x env -> (* 関数適用の場合 (caml2html: inline_app) *)
      let (zts, e) = M.find x env in
      Format.eprintf "inlining %s@." x;
      let env' =
        List.fold_left2
          (fun env' (z, t) y -> M.add z y env')
          M.empty
          zts
          ys in
      Alpha.g env' e.node (* locは関数が実行された位置 *)
  | LetTuple(xts, y, e) -> LetTuple(xts, y, h env e)
  | e -> e
and h env e =
  make_wloc (g env e.node) e.loc

let f e = h M.empty e
