open! Core
open Async

val component
  :  exit:(unit -> unit Bonsai_term.Effect.t)
  -> dimensions:Bonsai_term.Dimensions.t Bonsai.t
  -> local_ Bonsai.graph
  -> view:Bonsai_term.View.t Bonsai.t
     * handler:(Bonsai_term.Event.t -> unit Bonsai_term.Effect.t) Bonsai.t

val command : Command.t
