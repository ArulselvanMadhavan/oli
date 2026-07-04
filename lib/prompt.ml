open! Core
open! Bonsai_term
open Bonsai.Let_syntax

let prefix = "> "
let top_pad = 1

let view input = View.text (prefix ^ input)

let content_height ~(dimensions : Dimensions.t) ~title_bar_height =
  max 0 (dimensions.height - title_bar_height - top_pad)
;;

let body ~dimensions ~title_bar_height ~input =
  View.center
    ~within:{ dimensions with height = content_height ~dimensions ~title_bar_height }
    (view input)
;;

let main_view ~title_bar_config ~dimensions ~input =
  let width = Width.of_dimensions_exn dimensions in
  let title_bar = Title_bar.view ~width title_bar_config in
  let title_bar_height = View.height title_bar in
  View.vcat [ title_bar; View.pad ~t:top_pad (body ~dimensions ~title_bar_height ~input) ]
;;

let cursor_xy ~(dimensions : Dimensions.t) ~title_bar_height ~input =
  let line = prefix ^ input in
  let line_width = View.width (View.text line) in
  let left = (dimensions.width - line_width) / 2 in
  let top = (content_height ~dimensions ~title_bar_height - 1) / 2 in
  let x = left + line_width in
  let y = title_bar_height + top_pad + top in
  x, y
;;

let register_blinking_cursor ~dimensions ~title_bar_height ~input graph =
  let set_cursor = Effect.set_cursor graph in
  let after_display =
    let%arr dimensions and title_bar_height and input and set_cursor in
    let x, y = cursor_xy ~dimensions ~title_bar_height ~input in
    set_cursor (Some { position = { x; y }; kind = Cursor.Kind.Bar_blinking })
  in
  Bonsai.Edge.after_display after_display graph
;;

let handle_key ~input ~set_input (event : Event.t) =
  match event with
  | Key_press { key = ASCII c; mods = [] } when Char.is_print c ->
    set_input (input ^ String.of_char c)
  | Key_press { key = Backspace; mods = [] } ->
    if String.is_empty input
    then Effect.Ignore
    else set_input (String.sub input ~pos:0 ~len:(String.length input - 1))
  | _ -> Effect.Ignore
;;

let handler ~exit ~input ~set_input =
  let%arr set_input and input in
  fun (event : Event.t) ->
    if Input.quits event then exit () else handle_key ~input ~set_input event
;;
