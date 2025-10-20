type token =
  | BOOL of (
# 11 "myParser.mly"
        bool
# 6 "myParser.mli"
)
  | INT of (
# 12 "myParser.mly"
        int
# 11 "myParser.mli"
)
  | FLOAT of (
# 13 "myParser.mly"
        float
# 16 "myParser.mli"
)
  | NOT
  | MINUS
  | PLUS
  | MINUS_DOT
  | PLUS_DOT
  | AST_DOT
  | SLASH_DOT
  | EQUAL
  | LESS_GREATER
  | LESS_EQUAL
  | GREATER_EQUAL
  | LESS
  | GREATER
  | IF
  | THEN
  | ELSE
  | IDENT of (
# 30 "myParser.mly"
        Id.t
# 37 "myParser.mli"
)
  | LET
  | IN
  | REC
  | COMMA
  | ARRAY_CREATE
  | DOT
  | LESS_MINUS
  | SEMICOLON
  | LPAREN
  | RPAREN
  | EOF

val exp :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Syntax.t
