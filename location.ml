type loc = { start_pos : Lexing.position; end_pos : Lexing.position }
type 'a with_loc = { node : 'a; loc : loc }
