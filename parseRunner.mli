val f: string 
        -> ((Lexing.lexbuf -> MyParser.token) -> Lexing.lexbuf ->Syntax.t) 
        -> (Lexing.lexbuf -> MyParser.token) -> Lexing.lexbuf -> Syntax.t