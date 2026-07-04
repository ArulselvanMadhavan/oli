open! Core
open! Bonsai_term

let prefix = "> "

let view input = View.text (prefix ^ input)

let cursor_xy ~(dimensions : Dimensions.t) ~title_bar_height ~input =
  let top_pad = 1 in
  let content_height = max 0 (dimensions.height - title_bar_height - top_pad) in
  let line = prefix ^ input in
  let line_width = View.width (View.text line) in
  let left = (dimensions.width - line_width) / 2 in
  let top = (content_height - 1) / 2 in
  let x = left + line_width in
  let y = title_bar_height + top_pad + top in
  x, y
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
