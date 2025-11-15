let limit = ref 1000
let embedded_libraries = ref []
let linked_libraries = ref []

let concat_files output_file input_files =
  let oc = Out_channel.open_text output_file in
  List.iter (fun file ->
    let ic = In_channel.open_text file in
    Out_channel.output_string oc (In_channel.input_all ic);
    In_channel.close ic
  ) input_files;
  Out_channel.close oc

let embed_file input_file =
  if !embedded_libraries = [] then
    input_file ^ ".ml"
  else
    let dirname = input_file ^ "_ir" in
    MyPrint.create_dir dirname;
    let base = Filename.basename input_file in
    let output_file = Filename.concat dirname ("embedded_" ^ base ^ ".ml") in
    let embs = List.map (fun f -> f ^ ".ml") !embedded_libraries in
    concat_files output_file (embs @ [input_file ^ ".ml"]);
    output_file

(* Updated!: ParseRunnerを導入し、Parser実行・エラー処理・中間結果出力を任せる。 *)
let lexbuf outchan l filename = (* バッファをコンパイルしてチャンネルへ出力する (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  Emit.f outchan !linked_libraries
    (RegAlloc.f filename
       (Simm.f filename
          (Virtual.f filename
            (Flatten.f filename 
             (Closure.f filename
                (Optimize.f filename !limit
                  (Cse.f filename
                   (Alpha.f filename
                      (KNormal.f filename
                        (Typing.f
                          (ParseRunner.f filename MyParser.exp MyLexer.token l)))))))))))

(* let string s = lexbuf stdout (Lexing.from_string s) "" *) (* 文字列をコンパイルして標準出力に表示する (caml2html: main_string) *)

let file f = (* ファイルをコンパイルしてファイルに出力する (caml2html: main_file) *)
  let f_embedded = embed_file f in
  let inchan = open_in (f_embedded) in
  let outchan = open_out (f ^ ".s") in
  try
    lexbuf outchan (Lexing.from_channel inchan) f;
    close_in inchan;
    close_out outchan;
  with e -> (close_in inchan; close_out outchan; raise e)

let () = (* ここからコンパイラの実行が開始される (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated");
     ("-embed", Arg.String(fun s -> embedded_libraries := s :: !embedded_libraries), "embedded external libraries");
     ("-link", Arg.String(fun s -> linked_libraries := s :: !linked_libraries), "linked external libraries")]
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] [-embed <file>] [-link <file>]...filenames without \".ml\" nor \".s\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
  
