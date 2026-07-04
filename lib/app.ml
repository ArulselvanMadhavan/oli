open! Core
open! Bonsai_term
open Async
open Bonsai.Let_syntax

let title_bar_config =
  Title_bar.create ~project_name:Project_name.default ~username:(Username.current ())
;;

let component ~exit ~(dimensions : Dimensions.t Bonsai.t) (local_ _graph) =
  let view =
    let%arr dimensions in
    let width =
      match Width.of_int dimensions.width with
      | Ok width -> width
      | Error msg -> failwith msg
    in
    let title_bar = Title_bar.view ~width title_bar_config in
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
    if Input.quits event then exit () else Effect.Ignore
  in
  ~view, ~handler
;;

let command =
  Command.async_or_error
    ~summary:"Oli - Coding agent"
    (let%map_open.Command () = return () in
     fun () -> Bonsai_term.start_with_exit component)
;;
