(* Added!: 最適化処理のためのモジュール*)

let rec iter n e = (* 最適化処理をくりかえす (caml2html: main_iter) *)
  Format.eprintf "iteration %d@." n;
  if n = 0 then e else
  let e' = Cse.f_without_print (Elim.f (ConstFold.f (Inline.f (Assoc.f (Beta.f e))))) in
  if e = e' then e else
  iter (n - 1) e'

let f filename n e =
  Format.eprintf "optimizing...@.";
  let e' = iter n e in
  KNormal.print filename ".optimized" e';
  e'
  
