open! Core
open! Bonsai_term

let quits (event : Event.t) =
  match event with
  | Key_press { key = ASCII 'q' | ASCII 'Q'; mods = [] } -> true
  | Key_press { key = Escape; mods = [] } -> true
  | _ -> false
;;
