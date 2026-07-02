open! Core

(** A full-width title bar built with [Notty]. *)
val view
  :  width:int
  -> project_name:string
  -> username:string
  -> Bonsai_term.View.t

(** The underlying [Notty] image for the title bar. *)
val image
  :  width:int
  -> project_name:string
  -> username:string
  -> Notty.I.t
