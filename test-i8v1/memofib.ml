let memo = Array.make 100 (-1) in
let rec fib n =
  if n <= 1 then n
  else if n >= 100 then fib (n - 1) + fib (n - 2)
  else if memo.(n) = -1 then
  let result = fib (n - 1) + fib (n - 2) in
  memo.(n) <- result;
  result
  else memo.(n) 
in
print_int (fib 50) (* 12586269025 *)
