let a = f () in
let (x, y) = a in
let (y1, y2) = y in
print_int (x + y1);
let rec g x =
  (1, (2, 3)) in
let b = g () in
let c = h b in
print_int c
