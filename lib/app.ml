open! Core
open! Bonsai_term
open Async
open Bonsai.Let_syntax

let title_bar_config =
  Title_bar.create ~project_name:Project_name.default ~username:(Username.current ())
;;

let component ~exit ~(dimensions : Dimensions.t Bonsai.t) (local_ graph) =
  let input, set_input = Bonsai.state "" graph in
  let title_bar_height = Title_bar.height ~config:title_bar_config ~dimensions in
  let () =
    Prompt.register_blinking_cursor ~dimensions ~title_bar_height ~input graph
  in
  let view =
    let%arr dimensions and input in
    Prompt.main_view ~title_bar_config ~dimensions ~input
  in
  let handler = Prompt.handler ~exit ~input ~set_input in
  ~view, ~handler
;;

let command =
  Command.async_or_error
    ~summary:"Oli - Coding agent"
    (let%map_open.Command () = return () in
     fun () -> Bonsai_term.start_with_exit component)
;;
