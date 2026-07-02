open! Core
open! Bonsai_term
open Bonsai.Let_syntax

let project_name = "Oli"
let username = Oli.Welcome.username ()

let app ~exit ~(dimensions : Dimensions.t Bonsai.t) (local_ _graph)
  : view:View.t Bonsai.t * handler:(Event.t -> unit Effect.t) Bonsai.t
  =
  let view =
    let%arr dimensions in
    let title_bar =
      Oli.Title_bar.view ~width:dimensions.width ~project_name ~username
    in
    let body = View.text "Hello, World!" in
    let content_height = max 0 (dimensions.height - View.height title_bar - 1) in
    let main_content =
      View.center
        ~within:{ dimensions with height = content_height }
        body
    in
    View.vcat [ title_bar; View.pad ~t:1 main_content ]
  in
  let handler =
    Bonsai.return @@ fun (event : Event.t) ->
    match event with
    | Key_press { key = ASCII 'q' | ASCII 'Q'; mods = [] } -> exit ()
    | Key_press { key = Escape; mods = [] } -> exit ()
    | _ -> Effect.Ignore
  in
  ~view, ~handler
;;

let command =
  Async.Command.async_or_error
    ~summary:{|Oli - Coding agent|}
    (let%map_open.Command () = return () in
     fun () -> Bonsai_term.start_with_exit app)
;;

let () = Command_unix.run command
