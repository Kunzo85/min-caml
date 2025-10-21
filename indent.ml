(* Added!: インデント管理用のモジュール *)
(* Formatモジュールを使えばもっと簡単にできそうだが、実装時は知らなかったので仕方ない。いずれ置き換えるかも *)

type p = int ref

let create_indent () = ref 0 (* 新しいインデント状態を作成 *)
let indent p = String.make (!p * 2) ' ' (* 現在のインデントに応じた空白列を生成 *)
let push_indent p = incr p (* インデントを一段深くする *)
let pop_indent p = if !p > 0 then decr p (* インデントを一段浅くする *)

let with_indent p f = (* インデントを一段深くして関数を実行する *)
  push_indent p;
  let r =
    try f () with e -> pop_indent p; raise e
  in
  pop_indent p;
  r
