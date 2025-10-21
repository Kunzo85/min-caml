(* Added!: ソースコード上での位置情報を管理する。この情報をParserからEmitまで運ぶ。 *)

type loc = { start_pos : Lexing.position; end_pos : Lexing.position }
type 'a with_loc = { node : 'a; loc : loc }

let make_wloc node loc = { node; loc } (* ノードと位置情報を結合 *)
let ghost_loc () = { start_pos = Lexing.dummy_pos; end_pos = Lexing.dummy_pos } (* ダミー位置情報を生成 *)
