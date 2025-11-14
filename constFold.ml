(* Updated!: with_locに対応。 *)
(* 定数畳み込み最適化 *)

open KNormal
open Location

let memi x env =
  try (match M.find x env with Int(_) -> true | _ -> false)
  with Not_found -> false
let memf x env =
  try (match M.find x env with Float(_) -> true | _ -> false)
  with Not_found -> false
let memt x env =
  try (match M.find x env with Tuple(_) -> true | _ -> false)
  with Not_found -> false

let findi x env = (match M.find x env with Int(i) -> i | _ -> raise Not_found)
let findf x env = (match M.find x env with Float(d) -> d | _ -> raise Not_found)
let findt x env = (match M.find x env with Tuple(ys) -> ys | _ -> raise Not_found)

let rec g env e = (* 定数畳み込みルーチン本体 (caml2html: constfold_g) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Var(x) when memi x env -> inherit_loc (Int(findi x env))
  (* | Var(x) when memf x env -> Float(findf x env) *)
  (* | Var(x) when memt x env -> Tuple(findt x env) *)
  | Neg(x) when memi x env -> inherit_loc (Int(-(findi x env)))
  | Add(x, y) when memi x env && memi y env -> inherit_loc (Int(findi x env + findi y env)) (* 足し算のケース (caml2html: constfold_add) *)
  | Sub(x, y) when memi x env && memi y env -> inherit_loc (Int(findi x env - findi y env))
  | Sll(x, i) when memi x env -> inherit_loc (Int(findi x env lsl i))
  | Sra(x, i) when memi x env -> inherit_loc (Int(findi x env asr i))
  | FNeg(x) when memf x env -> inherit_loc (Float(-.(findf x env)))
  | FAdd(x, y) when memf x env && memf y env -> inherit_loc (Float(findf x env +. findf y env))
  | FSub(x, y) when memf x env && memf y env -> inherit_loc (Float(findf x env -. findf y env))
  | FMul(x, y) when memf x env && memf y env -> inherit_loc (Float(findf x env *. findf y env))
  | FDiv(x, y) when memf x env && memf y env -> inherit_loc (Float(findf x env /. findf y env))
  | FAbs(x) when memf x env -> inherit_loc (Float(abs_float (findf x env)))
  | FSqrt(x) when memf x env -> inherit_loc (Float(sqrt (findf x env)))
  | Floor(x) when memf x env -> inherit_loc (Float(floor (findf x env)))
  | FloatToInt(x) when memf x env -> inherit_loc (Int(int_of_float (findf x env)))
  | IntToFloat(x) when memi x env -> inherit_loc (Float(float_of_int (findi x env)))
  | IfEq(x, y, e1, e2) when memi x env && memi y env -> if findi x env = findi y env then g env e1 else g env e2
  | IfEq(x, y, e1, e2) when memf x env && memf y env -> if findf x env = findf y env then g env e1 else g env e2
  | IfEq(x, y, e1, e2) -> inherit_loc (IfEq(x, y, g env e1, g env e2))
  | IfLE(x, y, e1, e2) when memi x env && memi y env -> if findi x env <= findi y env then g env e1 else g env e2
  | IfLE(x, y, e1, e2) when memf x env && memf y env -> if findf x env <= findf y env then g env e1 else g env e2
  | IfLE(x, y, e1, e2) -> inherit_loc (IfLE(x, y, g env e1, g env e2))
  | Let((x, t), e1, e2) -> (* letのケース (caml2html: constfold_let) *)
      let e1' = g env e1 in
      let e2' = g (M.add x e1'.node env) e2 in
      inherit_loc (Let((x, t), e1', e2'))
  | LetRec({ node = { name = x; args = ys; body = e1 }; loc = fdloc}, e2) ->
      inherit_loc (LetRec(make_wloc { name = x; args = ys; body = g env e1 } fdloc, g env e2))
  | LetTuple(xts, y, e) when memt y env ->
      List.fold_left2
        (fun e' xt z -> inherit_loc (Let(xt, inherit_loc (Var(z)), e')))
        (g env e)
        xts
        (findt y env)
  | LetTuple(xts, y, e) -> inherit_loc (LetTuple(xts, y, g env e))
  | _ -> e

let f = g M.empty
