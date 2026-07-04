open! Core

type t = string [@@deriving sexp_of]

let of_string name =
  if String.is_empty name
  then Error "username cannot be empty"
  else Ok name
;;

let to_string t = t

let current () =
  match Sys.getenv "USER" with
  | Some user -> (
    match of_string user with
    | Ok user -> user
    | Error _ -> "user")
  | None -> (
    match of_string (Core_unix.username ()) with
    | Ok user -> user
    | Error _ -> "user")
;;
