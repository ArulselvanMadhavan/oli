open! Core

(** Resolve the current machine username. *)
val username : unit -> string

(** Welcome message text for a user. *)
val message : username:string -> string

(** Welcome message view for a user. *)
val view : username:string -> Bonsai_term.View.t
