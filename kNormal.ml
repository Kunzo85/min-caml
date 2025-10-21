(* give names to intermediate values (K-normalization) *)

open Location

type t' = (* K正規化後の式 (caml2html: knormal_t) *)
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
  | LetRec of fundef * t
  | App of Id.t * Id.t list
  | Tuple of Id.t list
  | LetTuple of (Id.t * Type.t) list * Id.t * t
  | Get of Id.t * Id.t
  | Put of Id.t * Id.t * Id.t
  | ExtArray of Id.t
  | ExtFunApp of Id.t * Id.t list
and fundef' = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }
and fundef = fundef' with_loc
and t = t' with_loc

let rec fv e = (* 式に出現する（自由な）変数 (caml2html: knormal_fv) *)
  match e.node with
  | Unit | Int(_) | Float(_) | ExtArray(_) -> S.empty
  | Neg(x) | FNeg(x) -> S.singleton x
  | Add(x, y) | Sub(x, y) | FAdd(x, y) | FSub(x, y) | FMul(x, y) | FDiv(x, y) | Get(x, y) -> S.of_list [x; y]
  | IfEq(x, y, e1, e2) | IfLE(x, y, e1, e2) -> S.add x (S.add y (S.union (fv e1) (fv e2)))
  | Let((x, t), e1, e2) -> S.union (fv e1) (S.remove x (fv e2))
  | Var(x) -> S.singleton x
  | LetRec({ node = { name = (x, t); args = yts; body = e1 }; _}, e2) ->
      let zs = S.diff (fv e1) (S.of_list (List.map fst yts)) in
      S.diff (S.union zs (fv e2)) (S.singleton x)
  | App(x, ys) -> S.of_list (x :: ys)
  | Tuple(xs) | ExtFunApp(_, xs) -> S.of_list xs
  | Put(x, y, z) -> S.of_list [x; y; z]
  | LetTuple(xs, y, e) -> S.add y (S.diff (fv e) (S.of_list (List.map fst xs)))

let insert_let (e, t) let_loc k = (* letを挿入する補助関数 (caml2html: knormal_insert) *)
  match e.node with
  | Var(x) -> k x
  | _ ->
      let x = Id.gentmp t in
      let e', t' = k x in
      make_wloc (Let((x, t), e, e')) let_loc, t'

let rec g env e = (* K正規化ルーチン本体 (caml2html: knormal_g) *)
    let inherit_loc t' = make_wloc t' e.loc in
    match e.node with
    | Syntax.Unit -> inherit_loc Unit, Type.Unit
    | Syntax.Bool(b) -> inherit_loc (Int(if b then 1 else 0)), Type.Int (* 論理値true, falseを整数1, 0に変換 (caml2html: knormal_bool) *)
    | Syntax.Int(i) -> inherit_loc (Int(i)), Type.Int
    | Syntax.Float(d) -> inherit_loc (Float(d)), Type.Float
    | Syntax.Not(e') -> 
        g env (inherit_loc 
                (Syntax.If(e', inherit_loc (Syntax.Bool(false)), inherit_loc (Syntax.Bool(true)))))
    | Syntax.Neg(e') ->
        insert_let (g env e') e.loc
          (fun x -> inherit_loc (Neg(x)), Type.Int)
    | Syntax.Add(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> inherit_loc (Add(x, y)), Type.Int))
    | Syntax.Sub(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> inherit_loc (Sub(x, y)), Type.Int))
    | Syntax.FNeg(e') ->
        insert_let (g env e') e.loc
          (fun x -> inherit_loc (FNeg(x)), Type.Float)
    | Syntax.FAdd(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> inherit_loc (FAdd(x, y)), Type.Float))
    | Syntax.FSub(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> inherit_loc (FSub(x, y)), Type.Float))
    | Syntax.FMul(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> inherit_loc (FMul(x, y)), Type.Float))
    | Syntax.FDiv(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> inherit_loc (FDiv(x, y)), Type.Float))
    | Syntax.Eq _ | Syntax.LE _ as cmp ->
        g env (inherit_loc
                (Syntax.If(inherit_loc cmp, inherit_loc (Syntax.Bool(true)), inherit_loc (Syntax.Bool(false))))) (* 比較式をIf式に変換 (caml2html: knormal_cmp) *)
    | Syntax.If({ node = Syntax.Not e1; _ } , e2, e3) -> 
        g env (inherit_loc (Syntax.If(e1, e3, e2))) (* notによる分岐を変換 (caml2html: knormal_not) *)
    | Syntax.If({ node = Syntax.Eq(e1, e2); _}, e3, e4) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y ->
                let e3', t3 = g env e3 in
                let e4', t4 = g env e4 in
                inherit_loc (IfEq(x, y, e3', e4')), t3))
    | Syntax.If({ node = Syntax.LE(e1, e2); _}, e3, e4) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y ->
                let e3', t3 = g env e3 in
                let e4', t4 = g env e4 in
                inherit_loc (IfLE(x, y, e3', e4')), t3))
    | Syntax.If(e1, e2, e3) -> 
        g env (inherit_loc 
                (Syntax.If(inherit_loc (Syntax.Eq(e1, inherit_loc (Syntax.Bool(false)))), 
                  e3, e2))) (* 比較のない分岐を変換 (caml2html: knormal_if) *)
    | Syntax.Let((x, t), e1, e2) ->
        let e1', t1 = g env e1 in
        let e2', t2 = g (M.add x t env) e2 in
        inherit_loc (Let((x, t), e1', e2')), t2
    | Syntax.Var(x) when M.mem x env -> inherit_loc (Var(x)), M.find x env
    | Syntax.Var(x) -> (* 外部配列の参照 (caml2html: knormal_extarray) *)
        (match M.find x !Typing.extenv with
        | Type.Array(_) as t -> inherit_loc (ExtArray x), t
        | _ -> failwith (Printf.sprintf "external variable %s does not have an array type" x))
    | Syntax.LetRec({ node = { Syntax.name = (x, t); Syntax.args = yts; Syntax.body = e1 }; loc = fdloc}, e2) ->
        let env' = M.add x t env in
        let e2', t2 = g env' e2 in
        let e1', t1 = g (M.add_list yts env') e1 in
        let fundef = make_wloc { name = (x, t); args = yts; body = e1' } fdloc in
        inherit_loc (LetRec(fundef, e2')), t2
    | Syntax.App({ node = Syntax.Var(f); _}, e2s) when not (M.mem f env) -> (* 外部関数の呼び出し (caml2html: knormal_extfunapp) *)
        (match M.find f !Typing.extenv with
        | Type.Fun(_, t) ->
            let rec bind xs = function (* "xs" are identifiers for the arguments *)
              | [] -> inherit_loc (ExtFunApp(f, xs)), t
              | e2 :: e2s ->
                  insert_let (g env e2) e.loc
                    (fun x -> bind (xs @ [x]) e2s) in
            bind [] e2s (* left-to-right evaluation *)
        | _ -> assert false)
    | Syntax.App(e1, e2s) ->
        (match g env e1 with
        | _, Type.Fun(_, t) as g_e1 ->
            insert_let g_e1 e.loc
              (fun f ->
                let rec bind xs = function (* "xs" are identifiers for the arguments *)
                  | [] -> inherit_loc (App(f, xs)), t
                  | e2 :: e2s ->
                      insert_let (g env e2) e.loc
                        (fun x -> bind (xs @ [x]) e2s) in
                bind [] e2s) (* left-to-right evaluation *)
        | _ -> assert false)
    | Syntax.Tuple(es) ->
        let rec bind xs ts = function (* "xs" and "ts" are identifiers and types for the elements *)
          | [] -> inherit_loc (Tuple(xs)), Type.Tuple(ts)
          | e' :: es ->
              let _, t as g_e = g env e' in
              insert_let g_e e.loc
                (fun x -> bind (xs @ [x]) (ts @ [t]) es) in
        bind [] [] es
    | Syntax.LetTuple(xts, e1, e2) ->
        insert_let (g env e1) e.loc
          (fun y ->
            let e2', t2 = g (M.add_list xts env) e2 in
            inherit_loc (LetTuple(xts, y, e2')), t2)
    | Syntax.Array(e1, e2) ->
        insert_let (g env e1) e.loc
          (fun x ->
            let _, t2 as g_e2 = g env e2 in
            insert_let g_e2 e.loc
              (fun y ->
                let l =
                  match t2 with
                  | Type.Float -> "create_float_array"
                  | _ -> "create_array" in
                inherit_loc (ExtFunApp(l, [x; y])), Type.Array(t2)))
    | Syntax.Get(e1, e2) ->
        (match g env e1 with
        | _, Type.Array(t) as g_e1 ->
            insert_let g_e1 e.loc
              (fun x -> insert_let (g env e2) e.loc
                  (fun y -> inherit_loc (Get(x, y)), t))
        | _ -> assert false)
    | Syntax.Put(e1, e2, e3) ->
        insert_let (g env e1) e.loc
          (fun x -> insert_let (g env e2) e.loc
              (fun y -> insert_let (g env e3) e.loc
                  (fun z -> inherit_loc (Put(x, y, z)), Type.Unit)))

let rec output p t =
  let loc_str = Printf.sprintf "!%d" t.loc.start_pos.Lexing.pos_lnum in
  match t.node with
  | Unit -> "() " ^ loc_str
  | Int(i) -> string_of_int i ^ " " ^ loc_str
  | Float(d) -> string_of_float d ^ " " ^ loc_str
  | Neg(x) -> Printf.sprintf "(Neg %s %s)" x loc_str
  | Add(x, y) -> Printf.sprintf "(Add %s %s %s)" x y loc_str
  | Sub(x, y) -> Printf.sprintf "(Sub %s %s %s)" x y loc_str
  | FNeg(x) -> Printf.sprintf "(FNeg %s %s)" x loc_str
  | FAdd(x, y) -> Printf.sprintf "(FAdd %s %s %s)" x y loc_str
  | FSub(x, y) -> Printf.sprintf "(FSub %s %s %s)" x y loc_str
  | FMul(x, y) -> Printf.sprintf "(FMul %s %s %s)" x y loc_str
  | FDiv(x, y) -> Printf.sprintf "(FDiv %s %s %s)" x y loc_str
  | IfEq(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      Printf.sprintf 
        "(If (EQ %s %s) Then\n%s\n%sElse\n%s %s)" 
        x y then_str (Indent.indent p) else_str loc_str
  | IfLE(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      Printf.sprintf 
        "(If (LE %s %s) Then\n%s\n%sElse\n%s %s)"
        x y then_str (Indent.indent p) else_str loc_str
  | Let((x, t), e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(Let %s:%s =\n%s\n%sIn\n%s %s)"
        x (Type.output t) e1_str (Indent.indent p) e2_str loc_str
  | Var(x) -> x ^ " " ^ loc_str
  | LetRec({ node = { name = (x, t); args = yts; body = e1 }; _}, e2) ->
      let args_str = String.concat " " (List.map (fun (y, t) -> Printf.sprintf "%s:%s" y (Type.output t)) yts) in
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(LetRec %s:%s %s =\n%s\nIn\n%s %s)"
        x (Type.output t) args_str e1_str e2_str loc_str
  | App(x, ys) ->
      let ys_str = String.concat " " ys in
      Printf.sprintf "(%s %s %s)" x ys_str loc_str
  | Tuple(xs) ->
      let xs_str = String.concat ", " xs in
      Printf.sprintf "(Tuple %s %s)" xs_str loc_str
  | LetTuple(xts, y, e') ->
      let xts_str = String.concat ", " (List.map (fun (x, t) -> Printf.sprintf "%s:%s" x (Type.output t)) xts) in
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e') in
      Printf.sprintf 
        "(Let (%s) = %s In\n%s %s)"
        xts_str y e_str loc_str
  | Get(x, y) -> Printf.sprintf "(%s.(%s) %s)" x y loc_str
  | Put(x, y, z) -> Printf.sprintf "(%s.(%s) <- %s %s)" x y z loc_str
  | ExtArray(x) -> Printf.sprintf "Ext_Array %s %s" x loc_str
  | ExtFunApp(f, xs) ->
      let xs_str = String.concat " " xs in
      Printf.sprintf "%s %s %s" f xs_str loc_str

(* let rec output p = function
  | Unit -> "()"
  | Int(i) -> string_of_int i
  | Float(d) -> string_of_float d
  | Neg(x) -> Printf.sprintf "(Neg %s)" x
  | Add(x, y) -> Printf.sprintf "(Add %s %s)" x y
  | Sub(x, y) -> Printf.sprintf "(Sub %s %s)" x y
  | FNeg(x) -> Printf.sprintf "(FNeg %s)" x
  | FAdd(x, y) -> Printf.sprintf "(FAdd %s %s)" x y
  | FSub(x, y) -> Printf.sprintf "(FSub %s %s)" x y
  | FMul(x, y) -> Printf.sprintf "(FMul %s %s)" x y
  | FDiv(x, y) -> Printf.sprintf "(FDiv %s %s)" x y
  | IfEq(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      Printf.sprintf 
        "(If (EQ %s %s) Then\n%s\n%sElse\n%s)" 
        x y then_str (Indent.indent p) else_str
  | IfLE(x, y, e1, e2) ->
      let then_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let else_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      Printf.sprintf 
        "(If (LE %s %s) Then\n%s\n%sElse\n%s)"
        x y then_str (Indent.indent p) else_str
  | Let((x, t), e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(Let %s:%s =\n%s\n%sIn\n%s)"
        x (Type.output t) e1_str (Indent.indent p) e2_str
  | Var(x) -> x
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let args_str = String.concat " " (List.map (fun (y, t) -> Printf.sprintf "%s:%s" y (Type.output t)) yts) in
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(LetRec %s:%s %s =\n%s\nIn\n%s)"
        x (Type.output t) args_str e1_str e2_str
  | App(x, ys) ->
      let ys_str = String.concat " " ys in
      Printf.sprintf "(%s %s)" x ys_str
  | Tuple(xs) ->
      let xs_str = String.concat ", " xs in
      Printf.sprintf "(Tuple %s)" xs_str
  | LetTuple(xts, y, e') ->
      let xts_str = String.concat ", " (List.map (fun (x, t) -> Printf.sprintf "%s:%s" x (Type.output t)) xts) in
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e') in
      Printf.sprintf 
        "(Let (%s) = %s In\n%s)"
        xts_str y e_str
  | Get(x, y) -> Printf.sprintf "(%s.(%s))" x y
  | Put(x, y, z) -> Printf.sprintf "(%s.(%s) <- %s)" x y z
  | ExtArray(x) -> Printf.sprintf "Ext_Array %s" x
  | ExtFunApp(f, xs) ->
      let xs_str = String.concat " " xs in
      Printf.sprintf "%s %s" f xs_str *)

let print filename t =
  let outchan = open_out (filename ^ ".normalized") in
  let p = Indent.create_indent () in
  let _ = output_string outchan (output p t ^ "\n") in
  close_out outchan

let f filename e = 
  Format.eprintf "K-normalizing...@.";
  let t = fst (g M.empty e) in
  print filename t;
  t

(* let f filename e =
  Unit *)
