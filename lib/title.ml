open! Core
open Bonsai_term

let lamp_icon = "💡"

let view ~project_name =
  View.hcat
    [ View.text
        ~attrs:[ Attr.fg (Attr.Color.rgb ~r:255 ~g:200 ~b:50) ]
        lamp_icon
    ; View.text " "
    ; View.text ~attrs:[ Attr.bold ] project_name
    ]
;;
