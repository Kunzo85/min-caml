type t = (* MinCamlの構文を表現するデータ型 (caml2html: syntax_t) *)
  | Unit
  | Bool of bool
  | Int of int
  | Float of float
  | Not of t
  | Neg of t
  | Add of t * t
  | Sub of t * t
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
and fundef = { name : Id.t * Type.t; args : (Id.t * Type.t) list; body : t }

let rec output p = function
  | Unit -> "()" 
  | Bool(b) -> string_of_bool b
  | Int(i) -> string_of_int i
  | Float(d) -> string_of_float d
  | Not(e) -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(Not\n%s)" e_str
  | Neg(e) -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(Neg\n%s)" e_str
  | Add(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Add\n%s\n%s)" e1_str e2_str
  | Sub(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Sub\n%s\n%s)" e1_str e2_str
  | FNeg(e) -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(FNeg\n%s)" e_str
  | FAdd(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FAdd\n%s\n%s)" e1_str e2_str
  | FSub(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FSub\n%s\n%s)" e1_str e2_str
  | FMul(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FMul\n%s\n%s)" e1_str e2_str
  | FDiv(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FDiv\n%s\n%s)" e1_str e2_str
  | Eq(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Eq\n%s\n%s)" e1_str e2_str
  | LE(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(LE\n%s\n%s)" e1_str e2_str
  | If(e1, e2, e3) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e3)) in
      Printf.sprintf 
        "(If\n%s\n%sThen\n%s\n%sElse\n%s)" 
        e1_str (Indent.indent p) e2_str (Indent.indent p) e3_str
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
        "(LetRec %s:%s %s =\n%s\n%sIn\n%s)"
        x (Type.output t) args_str e1_str (Indent.indent p) e2_str
  | App(e, es) ->
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      let es_str = String.concat "\n" (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ output p e)) es) in
      Printf.sprintf "(App\n%s\n%s)" e_str es_str
  | Tuple(es) ->
      let es_str = String.concat (",\n") (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ output p e)) es) in
      Printf.sprintf "(Tuple\n%s)" es_str
  | LetTuple(xts, y, e) ->
      let xts_str = String.concat ", " (List.map (fun (x, t) -> Printf.sprintf "%s:%s" x (Type.output t)) xts) in
      let y_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p y) in
      let e_str = Indent.indent p ^ output p e in
      Printf.sprintf 
        "(LetTuple (%s) =\n%s\n%sIn\n%s)"
        xts_str y_str (Indent.indent p) e_str
  | Array(e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Array\n%s\n%s)" e1_str e2_str
  | Get(e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Get\n%s\n%s)" e1_str e2_str
  | Put(e1, e2, e3) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e3) in
      Printf.sprintf "(Put\n%s\n%s\n%s)" e1_str e2_str e3_str

let print filename e =
  let outchan = open_out (filename ^ ".parsed") in
  let p = Indent.create_indent () in
  let _ = output_string outchan (output p e ^ "\n") in
  close_out outchan;
  e
