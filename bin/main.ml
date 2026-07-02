open! Core
open! Bonsai_term
open Bonsai.Let_syntax

let project_name = "Oli"

let app ~(dimensions : Dimensions.t Bonsai.t) (local_ _graph)
  : view:View.t Bonsai.t * handler:(Event.t -> unit Effect.t) Bonsai.t
  =
  let view =
    let%arr dimensions in
    let title = Oli.Title.view ~project_name in
    let body = View.text "Hello, World!" in
    View.center ~within:dimensions (View.vcat [ title; body ])
  in
  let handler = Bonsai.return (fun _ -> Effect.Ignore) in
  ~view, ~handler
;;

let command =
  Async.Command.async_or_error
    ~summary:{|Oli - Coding agent|}
    (let%map_open.Command () = return () in
     fun () -> Bonsai_term.start app)
;;

let () = Command_unix.run command
