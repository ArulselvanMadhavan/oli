open! Core

type t = private string
[@@deriving sexp_of]

val current : unit -> t

val of_string : string -> (t, string) Result.t

val to_string : t -> string
