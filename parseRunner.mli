(* Added!: Parser実行・エラー処理・中間結果出力を担当。 *)

val f: string 
        -> ((Lexing.lexbuf -> MyParser.token) -> Lexing.lexbuf ->Syntax.t) 
        -> (Lexing.lexbuf -> MyParser.token) -> Lexing.lexbuf -> Syntax.t