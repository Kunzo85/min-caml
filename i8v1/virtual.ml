(* Updated!: with_locに対応 *)

(* translation into PowerPC assembly with infinite number of virtual registers *)

open Asm
open Location

(* let data = ref [] *) (* 浮動小数点数の定数テーブル (caml2html: virtual_data) *)
(* v1では浮動小数点数定数テーブルは使わない *)

let classify xts ini addf addi =
  List.fold_left
    (fun acc (x, t) ->
      match t with
      | Type.Unit -> acc
      | Type.Float -> addf acc x
      | _ -> addi acc x t)
    ini
    xts

let separate xts =
  classify
    xts
    ([], [])
    (fun (int, float) x -> (int, float @ [x]))
    (fun (int, float) x _ -> (int @ [x], float))

let expand xts ini addf addi =
  classify
    xts
    ini
    (fun (offset, acc) x ->
      (* let offset = align offset in *) (* v1では単精度なので4バイト *)
      (offset + 4, addf x offset acc))
    (fun (offset, acc) x t ->
      (offset + 4, addi x t offset acc))

(* offset系は4バイト単位で計算なう！もしコアで4倍される仕様なら、1ずつ足す必要がある！ *)
let rec g env e = (* 式の仮想マシンコード生成 (caml2html: virtual_g) *)
  let inherit_loc node = make_wloc node e.loc in
  match e.node with
  | Closure.Unit -> Ans(inherit_loc Nop)
  | Closure.Int(i) -> Ans(inherit_loc (Li(i)))
  | Closure.Float(d) -> Ans(inherit_loc (FLi(d))) (* v1では浮動小数点数定数テーブルは使わない *)
  | Closure.Neg(x) -> Ans(inherit_loc (Sub(reg_zero, V(x)))) (* xがSimmで消えることはないので、ここでSubに変換 *)
  | Closure.Add(x, y) -> Ans(inherit_loc (Add(x, V(y))))
  | Closure.Sub(x, y) -> Ans(inherit_loc (Sub(x, V(y))))
  | Closure.FNeg(x) -> Ans(inherit_loc (FNeg(x)))
  | Closure.FAdd(x, y) -> Ans(inherit_loc (FAdd(x, y)))
  | Closure.FSub(x, y) -> Ans(inherit_loc (FSub(x, y)))
  | Closure.FMul(x, y) -> Ans(inherit_loc (FMul(x, y)))
  | Closure.FDiv(x, y) -> Ans(inherit_loc (FDiv(x, y)))
  | Closure.IfEq(x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> Ans(inherit_loc (IfEq(x, y, g env e1, g env e2)))
      | Type.Float -> Ans(inherit_loc (IfFEq(x, y, g env e1, g env e2)))
      | _ -> failwith "equality supported only for bool, int, and float")
  | Closure.IfLE(x, y, e1, e2) ->
      (match M.find x env with
      | Type.Bool | Type.Int -> Ans(inherit_loc (IfLE(x, y, g env e1, g env e2)))
      | Type.Float -> Ans(inherit_loc (IfFLE(x, y, g env e1, g env e2)))
      | _ -> failwith "inequality supported only for bool, int, and float")
  | Closure.Let((x, t1), e1, e2) ->
      let e1' = g env e1 in
      let e2' = g (M.add x t1 env) e2 in
      concat e1' (x, t1) e2'
  | Closure.Var(x) ->
      (match M.find x env with
      | Type.Unit -> Ans(inherit_loc Nop)
      | Type.Float -> Ans(inherit_loc (FMr(x)))
      | _ -> Ans(inherit_loc (Mr(x))))
  | Closure.MakeCls((x, t), { Closure.entry = l; Closure.actual_fv = ys }, e2) -> (* クロージャの生成 (caml2html: virtual_makecls) *)
      (* Closureのアドレスをセットしてから、自由変数の値をストア *)
      let e2' = g (M.add x t env) e2 in
      let offset, store_fv =
        expand
          (List.map (fun y -> (y, M.find y env)) ys)
          (4, e2')
          (fun y offset store_fv -> seq(inherit_loc (FStore(y, x, C(offset))), store_fv))
          (fun y _ offset store_fv -> seq(inherit_loc (Store(y, x, C(offset))), store_fv)) in
      Let((x, t), inherit_loc (Mr(reg_hp)),
          Let((reg_hp, Type.Int), inherit_loc (Add(reg_hp, C(offset))), (* offsetをalignしないように変更。今のところデータは全て4バイトなので。 *)
              let z = Id.genid "l" in
              Let((z, Type.Int), inherit_loc (SetL(l)),
                  seq(inherit_loc (Store(z, x, C(0))),
                      store_fv))))
  | Closure.AppCls(x, ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      Ans(inherit_loc (CallCls(x, int, float)))
  | Closure.AppDir(Id.L(x), ys) ->
      let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
      Ans(inherit_loc (CallDir(Id.L(x), int, float)))
  | Closure.Tuple(xs) -> (* 組の生成 (caml2html: virtual_tuple) *)
      let y = Id.genid "t" in
      let (offset, store) =
        expand
          (List.map (fun x -> (x, M.find x env)) xs)
          (0, Ans(inherit_loc (Mr(y))))
          (fun x offset store -> seq(inherit_loc (FStore(x, y, C(offset))), store))
          (fun x _ offset store -> seq(inherit_loc (Store(x, y, C(offset))), store))  in
      Let((y, Type.Tuple(List.map (fun x -> M.find x env) xs)), inherit_loc (Mr(reg_hp)),
          Let((reg_hp, Type.Int), inherit_loc (Add(reg_hp, C(offset))),
              store))
  | Closure.LetTuple(xts, y, e2) ->
      let s = Closure.fv e2 in
      let (offset, load) =
        expand
          xts
          (0, g (M.add_list xts env) e2)
          (fun x offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            fletd(x, inherit_loc (FLoad(y, C(offset))), load))
          (fun x t offset load ->
            if not (S.mem x s) then load else (* [XX] a little ad hoc optimization *)
            Let((x, t), inherit_loc (Load(y, C(offset))), load)) in
      load
  | Closure.Get(x, y) -> (* 配列の読み出し (caml2html: virtual_get) *) (* Load命令のoffsetは即値のみなので、先にxに足す必要がある。Simmでやろうかな *)
      let offset = Id.genid "o" in
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(inherit_loc Nop)
      | Type.Array(Type.Float) ->
          Let((offset, Type.Int), inherit_loc (Slw(y, C(2))), (* floatは4バイト単位なので、2シフト *)
              Ans(inherit_loc (FLoad(x, V(offset)))))
      | Type.Array(_) ->
          Let((offset, Type.Int), inherit_loc (Slw(y, C(2))),
              Ans(inherit_loc (Load(x, V(offset)))))
      | _ -> assert false)
  | Closure.Put(x, y, z) ->
      let offset = Id.genid "o" in
      (match M.find x env with
      | Type.Array(Type.Unit) -> Ans(inherit_loc Nop)
      | Type.Array(Type.Float) ->
          Let((offset, Type.Int), inherit_loc (Slw(y, C(2))),
              Ans(inherit_loc (FStore(z, x, V(offset)))))
      | Type.Array(_) ->
          Let((offset, Type.Int), inherit_loc (Slw(y, C(2))),
              Ans(inherit_loc (Store(z, x, V(offset)))))
      | _ -> assert false)
  | Closure.ExtArray(Id.L(x)) -> Ans(inherit_loc (SetL(Id.L("min_caml_" ^ x))))

(* 関数の仮想マシンコード生成 (caml2html: virtual_h) *)
let h { node = { Closure.name = (Id.L(x), t); Closure.args = yts; Closure.formal_fv = zts; Closure.body = e }; loc } =
  let inherit_loc node = make_wloc node loc in
  let (int, float) = separate yts in
  let (offset, load) =
    expand
      zts
      (4, g (M.add x t (M.add_list yts (M.add_list zts M.empty))) e)
      (fun z offset load -> fletd(z, inherit_loc (FLoad(x, C(offset))), load))
      (fun z t offset load -> Let((z, t), inherit_loc (Load(x, C(offset))), load)) in
  match t with
  | Type.Fun(_, t2) ->
      inherit_loc { name = Id.L(x); args = int; fargs = float; body = load; ret = t2 }
  | _ -> assert false

(* プログラム全体の仮想マシンコード生成 (caml2html: virtual_f) *)
let f filename (Closure.Prog(fundefs, e)) =
  (* data := []; *)
  let fundefs = List.map h fundefs in
  let e = g M.empty e in
  let p = Prog(fundefs, e) in
  print filename ".virtual" p;
  p
