(* Added!: Parser実行・エラー処理・中間結果出力を担当。 *)

open Syntax
open Location

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
