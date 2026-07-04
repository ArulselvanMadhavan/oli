open! Core
open! Bonsai_term

val prefix : string
val top_pad : int

(** Renders the shell prompt line. *)
val view : string -> View.t

(** Vertical space below the title bar for the centered prompt. *)
val content_height : dimensions:Dimensions.t -> title_bar_height:int -> int

(** Centered prompt within the area below the title bar. *)
val body : dimensions:Dimensions.t -> title_bar_height:int -> input:string -> View.t

(** Full layout: title bar plus centered prompt. *)
val main_view
  :  title_bar_config:Title_bar.t
  -> dimensions:Dimensions.t
  -> input:string
  -> View.t

(** Screen coordinates for the blinking cursor after the prompt. *)
val cursor_xy
  :  dimensions:Dimensions.t
  -> title_bar_height:int
  -> input:string
  -> int * int

(** Positions a blinking cursor after the prompt on every frame. *)
val register_blinking_cursor
  :  dimensions:Dimensions.t Bonsai.t
  -> title_bar_height:int Bonsai.t
  -> input:string Bonsai.t
  -> local_ Bonsai.graph
  -> unit

(** Updates [input] in response to printable keys and backspace. *)
val handle_key
  :  input:string
  -> set_input:(string -> unit Bonsai.Effect.t)
  -> Event.t
  -> unit Bonsai.Effect.t

(** Routes quit keys to [exit] and other keys to [handle_key]. *)
val handler
  :  exit:(unit -> unit Bonsai.Effect.t)
  -> input:string Bonsai.t
  -> set_input:(string -> unit Bonsai.Effect.t) Bonsai.t
  -> (Event.t -> unit Bonsai.Effect.t) Bonsai.t
