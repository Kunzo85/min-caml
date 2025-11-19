let rec fib x =
  if x < 2.0 then x else
    fib (x -. 1.0) +. fib (x -. 2.0)
in
print_float (fib 10.0)
