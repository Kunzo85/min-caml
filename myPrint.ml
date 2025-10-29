let create_dir dir =
  try Unix.mkdir dir 0o755 with Unix.Unix_error (Unix.EEXIST, _, _) -> ()

let print filename ext output e =
  let e_str = output (Indent.create_indent ()) e ^ "\n" in
  let dir = filename in
  create_dir dir;
  let base = Filename.basename filename in
  let out_filename = Filename.concat dir (base ^ ext) in
  let oc = open_out out_filename in
  output_string oc e_str;
  close_out oc

(* let print filename ext output e = (* .mlと同階層にファイルを生成 *)
  let e_str = output (Indent.create_indent ()) e ^ "\n" in
  let oc = open_out (filename ^ ext) in
  output_string oc e_str;
  close_out oc *)
