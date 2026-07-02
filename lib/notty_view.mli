open! Core

(** Convert a [Notty] image into a [Bonsai_term] view. *)
val of_image : Notty.I.t -> Bonsai_term.View.t
