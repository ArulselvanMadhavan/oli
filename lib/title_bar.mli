open! Core

type t [@@deriving sexp_of]

val create
  :  project_name:Project_name.t
  -> username:Username.t
  -> t

(** A full-width title bar built with [Notty]. *)
val view : width:Width.t -> t -> Bonsai_term.View.t

(** The underlying [Notty] image for the title bar. *)
val image : width:Width.t -> t -> Notty.I.t
