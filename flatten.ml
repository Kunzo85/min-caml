(* ネストした組の平坦化 *)

open Closure
open Location

let rec flatten_type = function (* 型を平坦化 *)
    | Type.Tuple(tl) ->
        let rec f acc = function
            | [] -> List.rev acc
            | Type.Tuple(tl') :: rest -> f (f acc tl') rest
            | t :: rest -> f (t :: acc) rest in
        Type.Tuple(f [] tl)
    | Type.Fun(tl, t) -> Type.Fun(List.map flatten_type tl, flatten_type t)
    | Type.Array(t) -> Type.Array(flatten_type t)
    | t -> t

let flatten_tuple known xs ts = (* タプルを構成する変数リストxsと型tsをknownに従って平坦化する *)
    let rec f xacc tacc xs ts =
        match xs, ts with
        | [], [] -> xacc, flatten_type (Type.Tuple(tacc)) (* flatten_typeは最後にまとめて適用。 *)
        | x :: xs', Type.Tuple(ts) :: ts' -> (* ネストしたタプルがある場合 *)
            let ys = M.find x known in (* タプル変数->要素変数リストは必ず登録されているはず *)
            f (xacc @ ys) (tacc @ ts) xs' ts' (* フラットに展開して渡す *)
        | x :: xs', t :: ts' -> (* ネストしていない場合 *)
            f (xacc @ [x]) (tacc @ [t]) xs' ts' 
        | _, _ -> failwith "flatten_tuple: length mismatch" in
    f [] [] xs ts

let replace repenv x = (* 変数xをrepenvに従って置き換える *)
    try M.find x repenv
    with Not_found -> x

let rec g known repenv e = (* メインルーチン *)
    (* known: タプル変数->要素の変数のリスト。
            Let式でTupleを生成する際に更新する。
            関数の返り値など、要素に変数が与えられていない場合は、直後にLetTuple式を挿入することで変数を与える。
            仮に、使わない要素に変数が与えられても、後のVirtualで削除されるので構わない。
            全てのタプル変数はknownに登録されることを想定。 *)
    (* repenv: 変数->変数のマッピング。
                LetTuple式が現れた際、knownを検索して、各要素変数の対応関係をrepenvに追加する。
                それ以外の式では、repenvを利用して変数を置き換えていく。 *)
    let inherit_loc node = make_wloc node e.loc in
    match e.node with
    | Unit | Int _ | Float _ | ExtArray _ -> e
    | Neg(x) -> inherit_loc (Neg(replace repenv x))
    | Add(x, y) -> inherit_loc (Add(replace repenv x, replace repenv y))
    | Sub(x, y) -> inherit_loc (Sub(replace repenv x, replace repenv y))
    | Sll(x, i) -> inherit_loc (Sll(replace repenv x, i))
    | Sra(x, i) -> inherit_loc (Sra(replace repenv x, i))
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
            | Tuple(ys) -> (* タプルの具体的な要素がわかっている場合 *)
                let flat_ys, flat_ts = flatten_tuple known ys ts in (* タプルがネストしている箇所を平坦化 *)
                let ys' = List.map (replace repenv) flat_ys in 
                assert (flat_ts = ft);
                let e2' = g (M.add x ys' known) repenv e2 in (* knownを更新してe2を処理 *)
                if S.mem x (fv e2') then
                    inherit_loc (Let((x, flat_ts), make_wloc (Tuple(ys')) e1.loc, e2'))
                else
                    e2' (* xがe2'で使われていなければ、Let式自体を消す *)
            | _ -> (* タプルの具体的な要素がわからない場合。AppCls,AppDir,Getなどを想定している *)
                let ts = (match ft with
                | Type.Tuple(ts) -> ts
                | _ -> failwith "flatten_tuple: not a tuple type after flattening") in
                let e1' = g known repenv e1 in
                let yts = List.map (fun t -> (Id.gentmp t, t)) ts in (* tsに従って、要素を入れる変数を生成 *)
                let e2' = g known repenv (inherit_loc (LetTuple(yts, x, e2))) in (* LetTuple式を挿入してe2を処理。ここでknownに登録されることを想定。 *)
                inherit_loc (Let((x, ft), e1', e2'))) 
        | _ -> 
            let e1' = g known repenv e1 in
            let e2' = g known repenv e2 in (* e1の処理で更新された環境は(スコープが切れているので)e2に引き継がない。 *)
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
    | Tuple(xs) -> (* Let((x,t),e1,e2)のe1には現れないことに注意 *)
        let xs' = List.fold_left 
                (fun acc x -> 
                    if M.mem x known then
                        acc @ (M.find x known) 
                    else
                        acc @ [replace repenv x]) [] xs in
        inherit_loc (Tuple(xs'))
    | LetTuple(xts, y, e2) -> 
        let xts', e2' = List.fold_left (* xtsを平坦化。その際、展開されたタプル変数がコードから消滅してはいけないので、直後にLet式を挿入 *)
                (fun (zts, e2') (z, t) -> 
                    let t' = flatten_type t in
                    match t' with 
                    | Tuple(ts) -> 
                        let zts' = List.map (fun t -> (Id.gentmp t, t)) ts in 
                        (zts @ zts', inherit_loc (Let((z, t'), inherit_loc (Tuple(List.map fst zts')), e2')))
                    | _ -> (zts @ [(z, t')], e2')) ([], e2) xts in
        let e2'' =
            if M.mem y known then (* yがすでにknownに登録されている場合 *)
                let ys = M.find y known in
                (* Printf.eprintf "Flatten LetTuple: %s -> [%s]\n" y (String.concat "; " ys); *)
                let rec f xts ys env = (* repenvの更新処理。List.fold_left2で書いてもよかった *)
                    (match xts, ys with
                    | [], [] -> env
                    | (x, _t) :: xts', y :: ys' -> f xts' ys' (M.add x (replace repenv y) env)
                    | _ -> failwith "flatten_tuple: length mismatch2") in
                let repenv' = f xts' ys repenv in
                (* Printf.eprintf "Flatten LetTuple: repenv': %s\n"
                    (String.concat "; " (List.map (fun (k, v) -> k ^ "->" ^ v) (M.bindings repenv'))); *)
                g known repenv' e2' 
            else (* yがknownに登録されていない場合 *)
                let known' = M.add y (List.map fst xts') known in (* ここでknownに登録 *)
                g known' repenv e2'
        in
        let fvs = fv e2'' in
        if List.exists (fun (x, _t) -> S.mem x fvs) xts' then
            inherit_loc (LetTuple(xts', y, e2''))
        else
            e2'' (* xts'の変数がe2''で使われていなければ、LetTuple式自体を消す *)
    | Get(x, y) ->
        inherit_loc (Get(replace repenv x, replace repenv y))
    | Put(x, y, z) ->
        inherit_loc (Put(replace repenv x, replace repenv y, replace repenv z))

let h { node = { name = (l, t); args = yts; formal_fv = zts; body = e }; loc } =
    (* 関数定義の平坦化。プログラム中の変数が置き換わるので、関数の定義も変更を伴う。
        外部関数の平坦化はできないので本来このgは破壊的だが、MinCamlのライブラリも自作するので壊れることはない *)
    let t' = flatten_type t in
    let yts' = List.map (fun (x, t) -> (x, flatten_type t)) yts in
    let zts' = List.map (fun (x, t) -> (x, flatten_type t)) zts in
    let xytss = List.fold_left (* タプル型の引数xと、その中身を受ける変数リストytsを格納 *)
                (fun xytss (x, t) -> 
                    let t' = flatten_type t in
                    match t' with
                    | Tuple(ts) ->  xytss @ [(x, (List.map (fun t -> (Id.gentmp t, t)) ts))]
                    | _ -> xytss) [] (yts' @ zts') in
    let e' = List.fold_left (fun e (x, yts) -> make_wloc (LetTuple(yts, x, e)) loc) e xytss in (* 関数定義の初めにLetTuple式を挿入 *)
    let e'' = g M.empty M.empty e' in
    { node = { name = (l, t'); args = yts'; formal_fv = zts'; body = e'' }; loc } 

let f filename p =
    print filename ".before_flatten" p;
    let Prog(fundefs, e) = p in
    let fundefs' = List.map h fundefs in
    let e' = g M.empty M.empty e in
    let p' = Prog(fundefs', e') in
    print filename ".after_flatten" p';
    p'

let f _filename p = p (* 一時的に無効化 *)
