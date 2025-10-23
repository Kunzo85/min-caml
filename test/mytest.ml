let rec g a b c = a + b + c in
let rec f n =
  if n <= 1 then n else
  g (n
  +
  n) 
  (n 
  -
  1)
  (n
  -
  2)
  + f (n - 2) in 
  let x = f 10 in
print_int x