(**************** 外部ライブラリ ****************)

(* let pi = 3.14159265358979323846 in
let two_pi = 2.0 *. pi in
let half_pi = 0.5 *. pi in *)

let rec fmod x y =
  x -. (floor (x /. y)) *. y
in

let rec reduce_to_pi x =
  let pi = 3.14159265358979323846 in
  let two_pi = 2.0 *. pi in
  let r = fmod x two_pi in
  if r > pi then r -. two_pi
  else if r < (-. pi) then r +. two_pi
  else r
in

let rec sin x =
  let pi = 3.14159265358979323846 in
  let half_pi = 0.5 *. pi in
  let x = reduce_to_pi x in
  let x = 
    if x > half_pi then pi -. x
    else if x < (-. half_pi) then -. pi -. x
    else x
  in
  let x2 = x *. x in
  let a3 = -. 1.0 /. 6.0 in
  let a5 = 1.0 /. 120.0 in
  let a7 = -. 1.0 /. 5040.0 in
  let a9 = 1.0 /. 362880.0 in
  let a11 = -. 1.0 /. 39916800.0 in
  x +. x *. x2 *. (a3 +. x2 *. (a5 +. x2 *. (a7 +. x2 *. (a9 +. x2 *. a11))))
in

let rec cos x =
  let pi = 3.14159265358979323846 in
  let half_pi = 0.5 *. pi in
  sin (half_pi -. x)
in

let rec atan x =
  let pi = 3.14159265358979323846 in
  let half_pi = 0.5 *. pi in
  let rec atan_poly x =
    let x2 = x *. x in
    let a3 = -. 1.0 /. 3.0 in
    let a5 = 1.0 /. 5.0 in
    let a7 = -. 1.0 /. 7.0 in
    let a9 = 1.0 /. 9.0 in
    let a11 = -. 1.0 /. 11.0 in
    x +. x *. x2 *. (a3 +. x2 *. (a5 +. x2 *. (a7 +. x2 *. (a9 +. x2 *. a11))))
  in
  if x > 1.0 then half_pi -. atan_poly (1.0 /. x)
  else if x < -1.0 then -. half_pi -. atan_poly (1.0 /. x)
  else atan_poly x
in

(**************** ここまで外部ライブラリ ****************)

