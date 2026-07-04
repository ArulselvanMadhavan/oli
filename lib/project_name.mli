open! Core

type t = private string
[@@deriving sexp_of]

val default : t
(** The project name derived from [(name ...)] in [dune-project]. *)

val of_string : string -> (t, string) Result.t

val to_string : t -> string
