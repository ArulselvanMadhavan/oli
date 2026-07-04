open! Core

type t = int [@@deriving sexp_of]

let of_int width =
  if width < 0
  then Error (sprintf "width must be non-negative, got %d" width)
  else Ok width
;;

let of_dimensions_exn (dimensions : Bonsai_term.Dimensions.t) =
  match of_int dimensions.width with
  | Ok width -> width
  | Error msg -> failwith msg
;;

let to_int t = t
