(* Added!: Parser実行・エラー処理・中間結果出力を担当。 *)

open Syntax
open Location

let rec output p = function (* 式(:Syntax.t)を表現する文字列を生成。 *)
  | {node = Unit; _} -> "()" 
  | {node = Bool(b); _} -> string_of_bool b
  | {node = Int(i); _} -> string_of_int i
  | {node = Float(d); _} -> string_of_float d
  | {node = Not(e); _} -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(Not\n%s)" e_str
  | {node = Neg(e); _} -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(Neg\n%s)" e_str
  | {node = Add(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Add\n%s\n%s)" e1_str e2_str
  | {node = Sub(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Sub\n%s\n%s)" e1_str e2_str
  | {node = FNeg(e); _} -> 
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      Printf.sprintf "(FNeg\n%s)" e_str
  | {node = FAdd(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FAdd\n%s\n%s)" e1_str e2_str
  | {node = FSub(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FSub\n%s\n%s)" e1_str e2_str
  | {node = FMul(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FMul\n%s\n%s)" e1_str e2_str
  | {node = FDiv(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(FDiv\n%s\n%s)" e1_str e2_str
  | {node = Eq(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Eq\n%s\n%s)" e1_str e2_str
  | {node = LE(e1, e2); _} -> 
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(LE\n%s\n%s)" e1_str e2_str
  | {node = If(e1, e2, e3); _} ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e1)) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e2)) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ (output p e3)) in
      Printf.sprintf 
        "(If\n%s\n%sThen\n%s\n%sElse\n%s)" 
        e1_str (Indent.indent p) e2_str (Indent.indent p) e3_str
  | {node = Let((x, t), e1, e2); _} ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(Let %s:%s =\n%s\n%sIn\n%s)"
        x (Type.output t) e1_str (Indent.indent p) e2_str
  | {node = Var(x); _} -> x
  | {node = LetRec({ node = { name = (x, t); args = yts; body = e1 }; _}, e2); _} ->
      let args_str = String.concat " " (List.map (fun (y, t) -> Printf.sprintf "%s:%s" y (Type.output t)) yts) in
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.indent p ^ output p e2 in
      Printf.sprintf 
        "(LetRec %s:%s %s =\n%s\n%sIn\n%s)"
        x (Type.output t) args_str e1_str (Indent.indent p) e2_str
  | {node = App(e, es); _} ->
      let e_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e) in
      let es_str = String.concat "\n" (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ output p e)) es) in
      Printf.sprintf "(App\n%s\n%s)" e_str es_str
  | {node = Tuple(es); _} ->
      let es_str = String.concat (",\n") (List.map (fun e -> Indent.with_indent p (fun () -> Indent.indent p ^ output p e)) es) in
      Printf.sprintf "(Tuple\n%s)" es_str
  | {node = LetTuple(xts, y, e); _} ->
      let xts_str = String.concat ", " (List.map (fun (x, t) -> Printf.sprintf "%s:%s" x (Type.output t)) xts) in
      let y_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p y) in
      let e_str = Indent.indent p ^ output p e in
      Printf.sprintf 
        "(LetTuple (%s) =\n%s\n%sIn\n%s)"
        xts_str y_str (Indent.indent p) e_str
  | {node = Array(e1, e2); _} ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Array\n%s\n%s)" e1_str e2_str
  | {node = Get(e1, e2); _} ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      Printf.sprintf "(Get\n%s\n%s)" e1_str e2_str
  | {node = Put(e1, e2, e3); _} ->
      let e1_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e1) in
      let e2_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e2) in
      let e3_str = Indent.with_indent p (fun () -> Indent.indent p ^ output p e3) in
      Printf.sprintf "(Put\n%s\n%s\n%s)" e1_str e2_str e3_str

let print filename e = (* 式(:Syntax.t)を文字列にしてファイルに出力。 *)
  let outchan = open_out (filename ^ ".parsed") in
  let p = Indent.create_indent () in
  let _ = output_string outchan (output p e ^ "\n") in
  close_out outchan

let f filename exp token l =
  let e = 
    try exp token l with
    | e -> Error.handle_exn e
  in
  print filename e;
  e
