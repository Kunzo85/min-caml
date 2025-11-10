(* ネストした組の平坦化 *)

open Closure
open Location

(* let rec has_nested_tuple = function
    | Type.Tuple(tl) ->
        List.exists (function
          | Type.Tuple(_) -> true
          | _ -> false) tl
    | Type.Fun(tl, t) -> List.exists has_nested_tuple (t :: tl)
    | Type.Array(t) -> has_nested_tuple t
    | _ -> false *)

let rec flatten_type = function (* 1段階、型を平坦化 *)
    | Type.Tuple(tl) ->
      let rec f acc = function
        | [] -> List.rev acc
        | Type.Tuple(tl') :: rest -> f (f acc tl') rest
        | t :: rest -> f (t :: acc) rest in
      Type.Tuple(f [] tl)
    | Type.Fun(tl, t) ->
      Type.Fun(List.map flatten_type tl, flatten_type t)
    | Type.Array(t) ->
      Type.Array(flatten_type t)
    | t -> t

(* let rec appears_except_tuple x cont = (* xはtuple型 *)
    match cont.node with
    | IfEq(y1, y2, e1, e2) | IfLE(y1, y2, e1, e2) ->
        x = y1 || x = y2 || appears_except_tuple x e1 || appears_except_tuple x e2
    | Let((_y, _t), e1, e2) ->
        appears_except_tuple x e1 || appears_except_tuple x e2
    | Var(y) -> x = y
    | MakeCls((y, _t), { entry = _l; actual_fv = ys }, e) ->
        List.exists (fun z -> z = x) ys || appears_except_tuple x e
    | AppCls(_y, ys) ->
        List.exists (fun z -> z = x) ys
    | AppDir(_l, ys) ->
        List.exists (fun z -> z = x) ys
    | LetTuple(ytss, y, e) ->
        x = y || appears_except_tuple x e
    | _ -> false *)

let flatten_tuple known xs ts =
    let rec f xacc tacc xs ts =
        match xs, ts with
        | [], [] -> xacc, flatten_type (Type.Tuple(tacc))
        | x :: xs', Type.Tuple(ts) :: ts' ->
            let ys = M.find x known in
            f (xacc @ ys) (tacc @ ts) xs' ts'
        | x :: xs', t :: ts' ->
            f (xacc @ [x]) (tacc @ [t]) xs' ts'
        | _, _ -> failwith "flatten_tuple: length mismatch" in
    f [] [] xs ts

let replace repenv x =
    try M.find x repenv
    with Not_found -> x

let rec g known repenv e =
    let inherit_loc node = make_wloc node e.loc in
    match e.node with
    | Unit | Int _ | Float _ | ExtArray _ -> e
    | Neg(x) -> inherit_loc (Neg(replace repenv x))
    | Add(x, y) -> inherit_loc (Add(replace repenv x, replace repenv y))
    | Sub(x, y) -> inherit_loc (Sub(replace repenv x, replace repenv y))
    | FNeg(x) -> inherit_loc (FNeg(replace repenv x))
    | FAdd(x, y) -> inherit_loc (FAdd(replace repenv x, replace repenv y))
    | FSub(x, y) -> inherit_loc (FSub(replace repenv x, replace repenv y))
    | FMul(x, y) -> inherit_loc (FMul(replace repenv x, replace repenv y))
    | FDiv(x, y) -> inherit_loc (FDiv(replace repenv x, replace repenv y))
    | IfEq(x, y, e1, e2) ->
        inherit_loc (IfEq(replace repenv x, replace repenv y, g known repenv e1, g known repenv e2))
    | IfLE(x, y, e1, e2) ->
        inherit_loc (IfLE(replace repenv x, replace repenv y, g known repenv e1, g known repenv e2))
    | Let((x, t), e1, e2) ->
        let ft = flatten_type t in
        (match t with
        | Type.Tuple(ts) ->
            (match e1.node with
            | Tuple(ys) ->
                let flat_ys, flat_ts = flatten_tuple known ys ts in
                let ys' = List.map (replace repenv) flat_ys in
                assert (flat_ts = ft);
                let e2' = g (M.add x ys' known) repenv e2 in
                inherit_loc (Let((x, flat_ts), make_wloc (Tuple(ys')) e1.loc, e2'))
            | _ ->
                let ts = (match ft with
                | Type.Tuple(ts) -> ts
                | _ -> failwith "flatten_tuple: not a tuple type after flattening") in
                let e1' = g known repenv e1 in
                let yts = List.map (fun t -> (Id.gentmp t, t)) ts in
                let e2' = g (M.add x (List.map fst yts) known) repenv e2 in
                inherit_loc (Let((x, ft), e1', inherit_loc (LetTuple(yts, x, e2')))))
        | _ -> 
            let e1' = g known repenv e1 in
            let e2' = g known repenv e2 in
            inherit_loc (Let((x, ft), e1', e2')))
    | Var(x) -> inherit_loc (Var(replace repenv x))
    | MakeCls((x, t), { entry = l; actual_fv = ys }, e2) ->
        let t' = flatten_type t in
        let cls = { entry = l; actual_fv = List.map (replace repenv) ys } in
        let e2' = g known repenv e2 in
        inherit_loc (MakeCls((x, t'), cls, e2'))
    | AppCls(x, ys) ->
        inherit_loc (AppCls(replace repenv x, List.map (replace repenv) ys))
    | AppDir(l, ys) ->
        inherit_loc (AppDir(l, List.map (replace repenv) ys))
    | Tuple(xs) ->
        inherit_loc (Tuple(List.map (replace repenv) xs))
    | LetTuple(xts, y, e2) ->
        let xts', e2' = List.fold_left 
                (fun (zts, e2') (z, t) -> 
                    let t' = flatten_type t in
                    match t' with 
                    | Tuple(ts) -> 
                        let zts' = List.map (fun t -> (Id.gentmp t, t)) ts in 
                        (zts @ zts', inherit_loc (Let((z, t'), inherit_loc (Tuple(List.map fst zts')), e2')))
                    | _ -> (zts @ [(z, t')], e2')) ([], e2) xts in
        let ys = M.find y known in
        Printf.eprintf "Flatten LetTuple: %s -> [%s]\n" y (String.concat "; " ys);
        let rec f xts ys env =
            (match xts, ys with
            | [], [] -> env
            | (x, _t) :: xts', y :: ys' -> f xts' ys' (M.add x (replace repenv y) env)
            | _ -> failwith "flatten_tuple: length mismatch2") in
        let repenv' = f xts' ys repenv in
        Printf.eprintf "Flatten LetTuple: repenv': %s\n"
            (String.concat "; " (List.map (fun (k, v) -> k ^ "->" ^ v) (M.bindings repenv')));
        let e2'' = g known repenv' e2' in
        inherit_loc (LetTuple(xts', y, e2''))
    | Get(x, y) ->
        inherit_loc (Get(replace repenv x, replace repenv y))
    | Put(x, y, z) ->
        inherit_loc (Put(replace repenv x, replace repenv y, replace repenv z))

let h { node = { name = (l, t); args = yts; formal_fv = zts; body = e }; loc } =
    let t' = flatten_type t in
    let yts' = List.map (fun (x, t) -> (x, flatten_type t)) yts in
    let zts' = List.map (fun (x, t) -> (x, flatten_type t)) zts in
    let xytss = List.fold_left
                (fun xytss (x, t) -> 
                    let t' = flatten_type t in
                    match t' with
                    | Tuple(ts) ->  xytss @ [(x, (List.map (fun t -> (Id.gentmp t, t)) ts))]
                    | _ -> xytss) [] (yts' @ zts') in
    let known = List.fold_left (fun known (x, yts) -> M.add x (List.map fst yts) known) M.empty xytss in
    let e' = g known M.empty e in
    let e'' = List.fold_left (fun e' (x, yts) -> make_wloc (LetTuple(yts, x, e')) loc) e' xytss in
    { node = { name = (l, t'); args = yts'; formal_fv = zts'; body = e'' }; loc} 


(* let g known repenv e =
    let inherit_loc node = make_wloc node e.loc in
    match e.node with
    | Let((x, t), e1, e2) ->
        (match e1.node with
        | Tuple(xs) ->
            let ts = (match t with
              | Type.Tuple(ts) -> ts
              | _ -> failwith "flatten_tuple: not a tuple type") in
            let flat_xs, flat_ts = flatten_tuple known xs ts in
            let known' = M.add x flat_xs known in
            let e2' = g known' e2 in
            if S.mem x (fv e2') then
                inherit_loc (Let((x, flat_ts), make_wloc (Tuple(flat_xs)) e1.loc, e2'))
            else e2'
        | Let(_) | LetTuple(_) -> failwith "flatten_tuple: nested let already exists."
        | _ ->
            let e1' = g known e1 in
            let e2' = g (M.add x e1'.node known) e2 in (* 後で直す *)
            inherit_loc (Let((x, t), e1', e2')))
    | LetTuple(xts, y, e2) ->
        let ys = M.find y known in
        let rec f xts ys =
            (match xts, ys with
            | [], [] -> []
            | (x, t) :: xts', y :: ys' ->
                if M.mem y known then *)

let f filename p =
    print filename ".before_flatten" p;
    let Prog(fundefs, e) = p in
    let fundefs' = List.map h fundefs in
    let e' = g M.empty M.empty e in
    let p' = Prog(fundefs', e') in
    print filename ".after_flatten" p';
    p'
