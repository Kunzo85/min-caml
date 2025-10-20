exception Syntax_error of Syntax.loc * string 
exception Typing_error of Syntax.t * Type.t * Type.t * string

let handle_exn e =
  match e with
  | Syntax_error ({Syntax.start_pos = sp; Syntax.end_pos = ep}, msg) ->
      failwith (Printf.sprintf "Syntax error: %s between (line %d, char %d) and (line %d, char %d)"
                  msg
                  sp.Lexing.pos_lnum (sp.Lexing.pos_cnum - sp.Lexing.pos_bol + 1)
                  ep.Lexing.pos_lnum (ep.Lexing.pos_cnum - ep.Lexing.pos_bol + 1))
  | Typing_error ({ Syntax.node = _; Syntax.loc = loc}, ty1, ty2, msg) ->
      failwith (Printf.sprintf "Typing error: %s between (line %d, char %d) and (line %d, char %d)\nType 1: %s\nType 2: %s"
                  msg
                  loc.start_pos.Lexing.pos_lnum (loc.start_pos.Lexing.pos_cnum - loc.start_pos.Lexing.pos_bol + 1)
                  loc.end_pos.Lexing.pos_lnum (loc.end_pos.Lexing.pos_cnum - loc.end_pos.Lexing.pos_bol + 1)
                  (Type.output ty1)
                  (Type.output ty2))
  | _ -> raise e
