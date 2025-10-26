let a = Array.create 5 0 in
let b = a in
a.(0) <- 2;
if a.(0) = b.(0) then print_int 1 else print_int 0
