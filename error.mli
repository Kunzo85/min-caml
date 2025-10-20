exception Syntax_error of Syntax.loc * string
exception Typing_error of Syntax.t * Type.t * Type.t * string

val handle_exn : exn -> 'a
