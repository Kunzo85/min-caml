(* Updated!: 構文木のノードに位置情報を持たせる。 *)

open Location

type t' = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
  | Unit
  | Bool of bool
  | Int of int 
  | Float of float
  | Not of t
  | Neg of t
  | Add of t * t
  | Sub of t * t
  | Mul of t * t
  | Div of t * t
  | FNeg of t
  | FAdd of t * t
  | FSub of t * t
  | FMul of t * t
  | FDiv of t * t
  | Eq of t * t
  | LE of t * t
  | If of t * t * t
  | Let of (Id.t * Type.t) * t * t
  | Var of Id.t
  | LetRec of fundef * t
  | App of t * t list
  | Tuple of t list
  | LetTuple of (Id.t * Type.t) list * t * t
  | Array of t * t
  | Get of t * t
  | Put of t * t * t
and fundef' = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }
and fundef = fundef' with_loc
and t = t' with_loc

let rec t_to_string p = function (* 式(:Syntax.t)を表現する文字列を生成。 *)
  | { node = Unit; _ } -> "()" 
  | { node = Bool(b); _ } -> string_of_bool b
  | { node = Int(i); _ } -> string_of_int i
  | { node = Float(d); _ } -> string_of_float d
  | { node = Not(e); _ } -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e) in
      Printf.sprintf "(Not\n%s)" e_str
  | { node = Neg(e); _ } -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e) in
      Printf.sprintf "(Neg\n%s)" e_str
  | { node = Add(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Add\n%s\n%s)" e1_str e2_str
  | { node = Sub(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Sub\n%s\n%s)" e1_str e2_str
  | { node = Mul(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Mul\n%s\n%s)" e1_str e2_str
  | { node = Div(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Div\n%s\n%s)" e1_str e2_str
  | { node = FNeg(e); _ } -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e) in
      Printf.sprintf "(FNeg\n%s)" e_str
  | { node = FAdd(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(FAdd\n%s\n%s)" e1_str e2_str
  | { node = FSub(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(FSub\n%s\n%s)" e1_str e2_str
  | { node = FMul(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(FMul\n%s\n%s)" e1_str e2_str
  | { node = FDiv(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(FDiv\n%s\n%s)" e1_str e2_str
  | { node = Eq(e1, e2); _ } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Eq\n%s\n%s)" e1_str e2_str
  | { node = LE(e1, e2); _  } -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(LE\n%s\n%s)" e1_str e2_str
  | { node = If(e1, e2, e3); _ } ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e1)) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e2)) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ (t_to_string p e3)) in
      Printf.sprintf 
        "(If\n%s\n%sThen\n%s\n%sElse\n%s)" 
        e1_str (Indent.indent p) e2_str (Indent.indent p) e3_str
  | { node = Let((x, t), e1, e2); _ } ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.indent p ^ t_to_string p e2 in
      Printf.sprintf 
        "(Let %s:%s =\n%s\n%sIn\n%s)"
        x (Type.t_to_string t) e1_str (Indent.indent p) e2_str
  | { node = Var(x); _ } -> x
  | { node = LetRec({ node = { name = (x, t); args = yts; body = e1 }; _}, e2); _ } ->
      let args_str = String.concat " " (List.map (fun (y, t) -> Printf.sprintf "%s:%s" y (Type.t_to_string t)) yts) in
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.indent p ^ t_to_string p e2 in
      Printf.sprintf 
        "(LetRec %s:%s %s =\n%s\n%sIn\n%s)"
        x (Type.t_to_string t) args_str e1_str (Indent.indent p) e2_str
  | { node = App(e, es); _ } ->
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e) in
      let es_str = String.concat "\n" (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e)) es) in
      Printf.sprintf "(App\n%s\n%s)" e_str es_str
  | { node = Tuple(es); _ } ->
      let es_str = String.concat (",\n") (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e)) es) in
      Printf.sprintf "(Tuple\n%s)" es_str
  | { node = LetTuple(xts, y, e); _ } ->
      let xts_str = String.concat ", " (List.map (fun (x, t) -> Printf.sprintf "%s:%s" x (Type.t_to_string t)) xts) in
      let y_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p y) in
      let e_str = Indent.indent p ^ t_to_string p e in
      Printf.sprintf 
        "(LetTuple (%s) =\n%s\n%sIn\n%s)"
        xts_str y_str (Indent.indent p) e_str
  | { node = Array(e1, e2); _ } ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Array\n%s\n%s)" e1_str e2_str
  | { node = Get(e1, e2); _ } ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      Printf.sprintf "(Get\n%s\n%s)" e1_str e2_str
  | { node = Put(e1, e2, e3); _ } ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e2) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ t_to_string p e3) in
      Printf.sprintf "(Put\n%s\n%s\n%s)" e1_str e2_str e3_str

let print filename ext e =
    MyPrint.print filename ext t_to_string e
