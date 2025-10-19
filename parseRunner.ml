let rec output p = function
  | Syntax.Unit -> "()" 
  | Syntax.Bool(b) -> string_of_bool b
  | Syntax.Int(i) -> string_of_int i
  | Syntax.Float(d) -> string_of_float d
  | Syntax.Not(e) -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(Not\n%s)" e_str
  | Syntax.Neg(e) -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(Neg\n%s)" e_str
  | Syntax.Add(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Add\n%s\n%s)" e1_str e2_str
  | Syntax.Sub(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Sub\n%s\n%s)" e1_str e2_str
  | Syntax.FNeg(e) -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(FNeg\n%s)" e_str
  | Syntax.FAdd(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FAdd\n%s\n%s)" e1_str e2_str
  | Syntax.FSub(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FSub\n%s\n%s)" e1_str e2_str
  | Syntax.FMul(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FMul\n%s\n%s)" e1_str e2_str
  | Syntax.FDiv(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FDiv\n%s\n%s)" e1_str e2_str
  | Syntax.Eq(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Eq\n%s\n%s)" e1_str e2_str
  | Syntax.LE(e1, e2) -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(LE\n%s\n%s)" e1_str e2_str
  | Syntax.If(e1, e2, e3) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e3)) in
      Printf.sprintf 
        "(If\n%s\n%sThen\n%s\n%sElse\n%s)" 
        e1_str (Indent.indent p) e2_str (Indent.indent p) e3_str
  | Syntax.Let((x, t), e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(Let %s:%s =\n%s\n%sIn\n%s)"
        x (Type.output t) e1_str (Indent.indent p) e2_str
  | Syntax.Var(x) -> x
  | Syntax.LetRec({ name = (x, t); args = yts; body = e1 }, e2) ->
      let args_str = String.concat " " (List.map (fun (y, t) -> Printf.sprintf "%s:%s" y (Type.output t)) yts) in
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(LetRec %s:%s %s =\n%s\n%sIn\n%s)"
        x (Type.output t) args_str e1_str (Indent.indent p) e2_str
  | Syntax.App(e, es) ->
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      let es_str = String.concat "\n" (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ output p e)) es) in
      Printf.sprintf "(App\n%s\n%s)" e_str es_str
  | Syntax.Tuple(es) ->
      let es_str = String.concat (",\n") (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ output p e)) es) in
      Printf.sprintf "(Tuple\n%s)" es_str
  | Syntax.LetTuple(xts, y, e) ->
      let xts_str = String.concat ", " (List.map (fun (x, t) -> Printf.sprintf "%s:%s" x (Type.output t)) xts) in
      let y_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p y) in
      let e_str = Indent.indent p ^ output p e in
      Printf.sprintf 
        "(LetTuple (%s) =\n%s\n%sIn\n%s)"
        xts_str y_str (Indent.indent p) e_str
  | Syntax.Array(e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Array\n%s\n%s)" e1_str e2_str
  | Syntax.Get(e1, e2) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Get\n%s\n%s)" e1_str e2_str
  | Syntax.Put(e1, e2, e3) ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e3) in
      Printf.sprintf "(Put\n%s\n%s\n%s)" e1_str e2_str e3_str

let print filename e =
  let outchan = open_out (filename ^ ".parsed") in
  let p = Indent.create_indent () in
  let _ = output_string outchan (output p e ^ "\n") in
  close_out outchan

let f filename exp token l =
  let e = 
    try exp token l with
    | Error.Syntax_error (sp, ep, msg) ->
        failwith (Printf.sprintf "lines %d-%d, characters %d-%d: %s"
                    sp.Lexing.pos_lnum ep.Lexing.pos_lnum
                    (sp.Lexing.pos_cnum - sp.Lexing.pos_bol + 1)
                    (ep.Lexing.pos_cnum - ep.Lexing.pos_bol + 1)
                    msg)
  in
  print filename e;
  e
