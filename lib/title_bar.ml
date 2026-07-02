open! Core
open Notty
open Notty.Infix

let lamp_icon = "💡"

let bar_bg = A.(bg (rgb_888 ~r:40 ~g:44 ~b:52))
let title_attrs = A.(fg (rgb_888 ~r:255 ~g:200 ~b:50) ++ st bold ++ bar_bg)
let welcome_attrs = A.(fg (rgb_888 ~r:180 ~g:190 ~b:200) ++ bar_bg)

let image ~width ~project_name ~username =
  let background = I.uchar bar_bg (Uchar.of_char ' ') width 1 in
  let left =
    I.(hpad 1 0 @@ string title_attrs (lamp_icon ^ " " ^ project_name))
  in
  let welcome =
    I.string welcome_attrs (Welcome.message ~username)
  in
  let center = I.hsnap ~align:`Middle width welcome in
  I.(left </> center </> background)
;;

let view ~width ~project_name ~username =
  Notty_view.of_image (image ~width ~project_name ~username)
;;
