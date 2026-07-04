open! Core
open! Bonsai_term
open Async
open Bonsai.Let_syntax

let title_bar_config =
  Title_bar.create ~project_name:Project_name.default ~username:(Username.current ())
;;

let component ~exit ~(dimensions : Dimensions.t Bonsai.t) (local_ graph) =
  let input, set_input = Bonsai.state "" graph in
  let title_bar_height =
    let%arr dimensions in
    let width =
      match Width.of_int dimensions.width with
      | Ok width -> width
      | Error msg -> failwith msg
    in
    View.height (Title_bar.view ~width title_bar_config)
  in
  let set_cursor = Effect.set_cursor graph in
  let after_display =
    let%arr dimensions and title_bar_height and input and set_cursor in
    let x, y = Prompt.cursor_xy ~dimensions ~title_bar_height ~input in
    set_cursor (Some { position = { x; y }; kind = Cursor.Kind.Bar_blinking })
  in
  let () = Bonsai.Edge.after_display after_display graph in
  let view =
    let%arr dimensions and input in
    let width =
      match Width.of_int dimensions.width with
      | Ok width -> width
      | Error msg -> failwith msg
    in
    let title_bar = Title_bar.view ~width title_bar_config in
    let title_bar_height = View.height title_bar in
    let content_height = max 0 (dimensions.height - title_bar_height - 1) in
    let prompt = Prompt.view input in
    let main_content =
      View.center
        ~within:{ dimensions with height = content_height }
        prompt
    in
    View.vcat [ title_bar; View.pad ~t:1 main_content ]
  in
  let handler =
    let%arr set_input and input in
    fun (event : Event.t) ->
      if Input.quits event
      then exit ()
      else Prompt.handle_key ~input ~set_input event
  in
  ~view, ~handler
;;

let command =
  Command.async_or_error
    ~summary:"Oli - Coding agent"
    (let%map_open.Command () = return () in
     fun () -> Bonsai_term.start_with_exit component)
;;
