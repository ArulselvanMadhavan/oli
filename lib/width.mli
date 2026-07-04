open! Core

type t = private int
[@@deriving sexp_of]

val of_int : int -> (t, string) Result.t

(** [of_dimensions_exn] converts terminal [width] to [t], failing on invalid values. *)
val of_dimensions_exn : Bonsai_term.Dimensions.t -> t

val to_int : t -> int
