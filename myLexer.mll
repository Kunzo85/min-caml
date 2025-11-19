{
(* Updated!: 改行を検知して、lexbufを更新するように変更。 *)
(* lexerが利用する変数、関数、型などの定義 *)
open MyParser
(* open Type *)

let forbidden_words = ["io_char"; "io_int"; "io_float"]

let check_identifier lexbuf id =
  if List.mem id forbidden_words then
    raise (Error.Lexing_error ({
      Location.start_pos = lexbuf.Lexing.lex_curr_p;
      Location.end_pos = lexbuf.Lexing.lex_curr_p
    }, "Identifier '" ^ id ^ "' is forbidden "))
  else
    id
}

(* 正規表現の略記 *)
let space = [' ' '\t' '\r']  (* \nカット *)
let digit = ['0'-'9']
let lower = ['a'-'z']
let upper = ['A'-'Z']

rule token = parse
| space+
    { token lexbuf }
| "\n"
    { Lexing.new_line lexbuf; (* 改行時にlexbufを更新 *)
      token lexbuf }
| "(*"
    { comment lexbuf; (* ネストしたコメントのためのトリック *)
      token lexbuf }
| '('
    { LPAREN }
| ')'
    { RPAREN }
| "true"
    { BOOL(true) }
| "false"
    { BOOL(false) }
| "not"
    { NOT }
| digit+ (* 整数を字句解析するルール (caml2html: lexer_int) *)
    { INT(int_of_string (Lexing.lexeme lexbuf)) }
| digit+ ('.' digit*)? (['e' 'E'] ['+' '-']? digit+)?
    { FLOAT(float_of_string (Lexing.lexeme lexbuf)) }
| '-' (* -.より後回しにしなくても良い? 最長一致? *)
    { MINUS }
| '+' (* +.より後回しにしなくても良い? 最長一致? *)
    { PLUS }
| '*'
    { AST }
| '/' 
    { SLASH }
| "-."
    { MINUS_DOT }
| "+."
    { PLUS_DOT }
| "*."
    { AST_DOT }
| "/."
    { SLASH_DOT }
| '='
    { EQUAL }
| "<>"
    { LESS_GREATER }
| "<="
    { LESS_EQUAL }
| ">="
    { GREATER_EQUAL }
| '<'
    { LESS }
| '>'
    { GREATER }
| "if"
    { IF }
| "then"
    { THEN }
| "else"
    { ELSE }
| "let"
    { LET }
| "in"
    { IN }
| "rec"
    { REC }
| ','
    { COMMA }
| '_'
    { IDENT(Id.gentmp Type.Unit) }
| "Array.create" | "Array.make" (* [XX] ad hoc *)
    { ARRAY_CREATE }
| '.'
    { DOT }
| "<-"
    { LESS_MINUS }
| ';'
    { SEMICOLON }
| "fequal"
    { FEQUAL }
| "fless"
    { FLESS }
| "fispos"
    { FISPOS }
| "fisneg"
    { FISNEG }
| "fiszero"
    { FISZERO }
| "fhalf"
    { FHALF }
| "fsqr"
    { FSQR }
| "fabs"
    { FABS }
| "fneg"
    { FNEG }
| "sqrt"
    { SQRT }
| "floor"
    { FLOOR }
| "int_of_float"
    { INT_OF_FLOAT }
| "float_of_int"
    { FLOAT_OF_INT }
| "print_char"
    { PRINT_CHAR }
| "print_int"
    { PRINT_INT }
| "print_float"
    { PRINT_FLOAT }
| "read_float"
    { READ_FLOAT }
| "read_int"
    { READ_INT }
| eof
    { EOF }
(* | lower (digit|lower|upper|'_')* 
    { IDENT(Lexing.lexeme lexbuf) } *)
| lower (digit|lower|upper|'_')* (* 他の「予約語」より後でないといけない *)
    { let id = Lexing.lexeme lexbuf in
      IDENT(check_identifier lexbuf id) }
| _
    { let pos = lexbuf.lex_curr_p in
      let loc = { Location.start_pos = pos; Location.end_pos = pos } in
      Format.eprintf "Lexing error: unknown token '%s' at line %d, char %d@."
        (Lexing.lexeme lexbuf)
        pos.pos_lnum
        (pos.pos_cnum - pos.pos_bol + 1);
      raise (Error.Lexing_error (loc, "Unknown token")) }
and comment = parse
| "\n"
    { Lexing.new_line lexbuf;
      comment lexbuf }
| "*)"
    { () }
| "(*"
    { comment lexbuf;
      comment lexbuf }
| eof
    { Format.eprintf "warning: unterminated comment@." }
| _
    { comment lexbuf }
