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
let rec t_to_string = function
  | Unit -> "Unit"
  | Bool -> "Bool"
  | Int -> "Int"
  | Float -> "Float"
  | Fun(ts1, t2) ->
      let rec f = function
        | [] -> t_to_string t2
        | t :: ts -> t_to_string t ^ " -> " ^ f ts in
      "(" ^ f ts1 ^ ")"
  | Tuple(ts) ->
      let rec f = function
        | [] -> ""
        | [t] -> t_to_string t
        | t :: ts -> t_to_string t ^ " * " ^ f ts in
      "(" ^ f ts ^ ")"
  | Array(t) -> "Array(" ^ t_to_string t ^ ")"
  | Var({contents = None}) -> "Var(?)"
  | Var({contents = Some(t)}) -> "Var(" ^ t_to_string t ^ ")"
