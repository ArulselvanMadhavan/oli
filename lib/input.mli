open! Core

(** Returns [true] when [event] should terminate the application. *)
val quits : Bonsai_term.Event.t -> bool
