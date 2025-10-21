type t = (* MinCamlの型を表現するデータ型 (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None) (* 新しい型変数を作る *)

(* Added!: 型(:Type.t)を表現する文字列を生成。 *)
let rec output = function
  | Unit -> "Unit"
  | Bool -> "Bool"
  | Int -> "Int"
  | Float -> "Float"
  | Fun(ts1, t2) ->
      let rec f = function
        | [] -> output t2
        | t :: ts -> output t ^ " -> " ^ f ts in
      "(" ^ f ts1 ^ ")"
  | Tuple(ts) ->
      let rec f = function
        | [] -> ""
        | [t] -> output t
        | t :: ts -> output t ^ " * " ^ f ts in
      "(" ^ f ts ^ ")"
  | Array(t) -> "Array(" ^ output t ^ ")"
  | Var({contents = None}) -> "Var(?)"
  | Var({contents = Some(t)}) -> "Var(" ^ output t ^ ")"
