type loc = { start_pos : Lexing.position; end_pos : Lexing.position }
type 'a with_loc = { node : 'a; loc : loc }

let make_wloc node loc = { node; loc }
let ghost_loc () = { start_pos = Lexing.dummy_pos; end_pos = Lexing.dummy_pos }
