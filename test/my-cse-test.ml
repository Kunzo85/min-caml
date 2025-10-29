let a = 10 in
let b = 20 in
let c = a + b in
let c1 = a + b in (* c *)
let c2 = b + a in (* c *)
let d = c + c1 in (* c + c *)
let d1 = c1 + c2 in (* d *)
let e = d - c in 
let f = c - d1 in (* eにはならない。c - d *)
let g =
  let h = e + f in
  let i = f + e in (* h *)
  let j = h + i in
  h + i (* j *)
in
let k = e + f in (* hにはならない。e + f *)
let rec func x y =
  let l = a + b in (* cにはならない。a + b *)
  l + x + y
in
let gunc = func in
let m = gunc (d - c) c1 in (* func e c *)
let n =
  if c1 = d1 then (* c = d *)
    let k1 = e + f in (* k *)
    let p = m + k1 in (* m + k *)
    p
  else
    let k2 = f + e in (* k *)
    let q = m + k2 in (* pにはならない。m + k *)
    q
in
let r = g + k + n in
let r1 = k + g + n in (* rにならず *)
let s = k + g - r1 in (* rで使ったg+kを表す変数を再利用? *)
let t = (c, c1, c2, d, d1, r) in
let t1 = (c2, c, c1, d1, d, r) in (* t *)
let t2 = (c1, c2, c, d, d1, r1) in (* tならず *)
let (u1, u2, u3, u4, u5, u6) = t1 in (* t *)
let v =
  if c1 < d1 then (* c < d *)
    let w = -u1 in
    let w1 = -u1 in (* w *)
    let w2 = -u2 in (* w1にはならない。-u2 *)
    w + w1 + w2
  else
    let x = -u3 in (* wにはならない。Neg(u3) *)
    x
in
let y = create_array s u6 in
let y1 = y in 
y.(s - 1) <- u4 + u5;
y1.(s - 1) <- u5 + u4; (* y.(s - 1) <- u4 + u5 *)
let z = y1.(s - 1) in
let z1 = y.(s - 1) in (* zにはならない。 *)
print_int (v + z + z1)