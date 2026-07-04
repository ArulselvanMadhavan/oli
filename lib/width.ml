open! Core

type t = int [@@deriving sexp_of]

let of_int width =
  if width < 0
  then Error (sprintf "width must be non-negative, got %d" width)
  else Ok width
;;

let to_int t = t
