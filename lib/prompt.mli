open! Core
open! Bonsai_term

val prefix : string

(** Renders the shell prompt line. *)
val view : string -> View.t

(** Screen coordinates for the blinking cursor after the prompt. *)
val cursor_xy
  :  dimensions:Dimensions.t
  -> title_bar_height:int
  -> input:string
  -> int * int
(** Updates [input] in response to printable keys and backspace. *)
val handle_key
  :  input:string
  -> set_input:(string -> unit Bonsai.Effect.t)
  -> Event.t
  -> unit Bonsai.Effect.t
