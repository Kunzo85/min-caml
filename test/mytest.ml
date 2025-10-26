let x = 10 in
let rec f a b = a + b + x in
let x = 20 in
let g = f in
print_int (g 10 20)
