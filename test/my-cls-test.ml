let rec f x = x + 1 in
let a = f 10 in
let rec g x = x + a in
let rec h x = g (f x) in
print_int (h 5 + g 10)