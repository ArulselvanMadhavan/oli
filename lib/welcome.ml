open! Core
open Bonsai_term

let username () =
  match Sys.getenv "USER" with
  | Some user -> user
  | None ->
    (try Core_unix.username () with
     | _ -> "user")
;;

let message ~username = sprintf "Welcome, %s!" username

let view ~username =
  View.text
    ~attrs:[ Attr.fg (Attr.Color.rgb ~r:180 ~g:190 ~b:200) ]
    (message ~username)
;;
