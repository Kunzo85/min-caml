(* Added!: エラー処理を一元的に行う。 *)

exception Lexing_error of Location.loc
exception Syntax_error of Location.loc * string 
exception Typing_error of Syntax.t * Type.t * Type.t * string
exception KNormal_error of Syntax.t * string

let handle_exn e =
  match e with
  | Lexing_error ({Location.start_pos = sp; Location.end_pos = _}) ->
      failwith (Printf.sprintf "Lexing error at line %d, char %d"
                  sp.Lexing.pos_lnum (sp.Lexing.pos_cnum - sp.Lexing.pos_bol + 1))
  | Syntax_error ({Location.start_pos = sp; Location.end_pos = ep}, msg) ->
      failwith (Printf.sprintf "Syntax error: %s between (line %d, char %d) and (line %d, char %d)"
                  msg
                  sp.Lexing.pos_lnum (sp.Lexing.pos_cnum - sp.Lexing.pos_bol + 1)
                  ep.Lexing.pos_lnum (ep.Lexing.pos_cnum - ep.Lexing.pos_bol + 1))
  | Typing_error ({ Location.node = _; Location.loc = loc}, ty1, ty2, msg) ->
      failwith (Printf.sprintf "Typing error: %s between (line %d, char %d) and (line %d, char %d)\nType 1: %s\nType 2: %s"
                  msg
                  loc.start_pos.Lexing.pos_lnum (loc.start_pos.Lexing.pos_cnum - loc.start_pos.Lexing.pos_bol + 1)
                  loc.end_pos.Lexing.pos_lnum (loc.end_pos.Lexing.pos_cnum - loc.end_pos.Lexing.pos_bol + 1)
                  (Type.t_to_string ty1)
                  (Type.t_to_string ty2))
  | KNormal_error ({ Location.node = _; Location.loc = loc}, msg) ->
      failwith (Printf.sprintf "KNormal error: %s between (line %d, char %d) and (line %d, char %d)"
                  msg
                  loc.start_pos.Lexing.pos_lnum (loc.start_pos.Lexing.pos_cnum - loc.start_pos.Lexing.pos_bol + 1)
                  loc.end_pos.Lexing.pos_lnum (loc.end_pos.Lexing.pos_cnum - loc.end_pos.Lexing.pos_bol + 1))
  | _ -> raise e
