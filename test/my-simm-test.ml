let a = 5 in
let b = -a in
let rec f x =
  let d = b + x in
  let e = x - b in
  let g = -e in
  g + d
in
let h = f (a + b) in
let i = a + h in
let j = a - h in
let k = h - a in
let arr = Array.create 10 0 in
let brr = Array.create 10 1.0 in
arr.(a) <- j;
brr.(a) <- 10.0;
let l = arr.(i) in
let m = l - a in
print_int (m)
