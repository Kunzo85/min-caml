(* Added!: ソースコード上での位置情報を管理する。この情報をParserからEmitまで運ぶ。 *)
(* このインターフェースいるのかな... *)

type loc = { start_pos : Lexing.position; end_pos : Lexing.position }
type 'a with_loc = { node : 'a; loc : loc }

val make_wloc : 'a -> loc -> 'a with_loc
val ghost_loc : unit -> loc
