(* Added!: Parser実行・エラー処理・中間結果出力を担当。 *)

open Syntax

let f filename exp token l =
  let e = 
    try exp token l with
    | e -> Error.handle_exn e
  in
  print filename ".parsed" e;
  e
