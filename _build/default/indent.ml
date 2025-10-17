(* 中間結果出力時のインデント管理 *)

type p = int ref

let create_indent () = ref 0
let indent p = String.make (!p * 2) ' '
let push_indent p = incr p
let pop_indent p = if !p > 0 then decr p

let with_indent p f =
  push_indent p;
  let r =
    try f () with e -> pop_indent p; raise e
  in
  pop_indent p;
  r
