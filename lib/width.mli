open! Core

type t = private int
[@@deriving sexp_of]

val of_int : int -> (t, string) Result.t

val to_int : t -> int
