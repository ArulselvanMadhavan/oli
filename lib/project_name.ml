open! Core

type t = string [@@deriving sexp_of]

let capitalize_first = function
  | "" -> ""
  | s -> String.of_char (Char.uppercase s.[0]) ^ String.drop_prefix s 1
;;

let of_string name =
  if String.is_empty name
  then Error "project name cannot be empty"
  else Ok name
;;

let to_string t = t

let default =
  match of_string (capitalize_first Project_name_config.identifier) with
  | Ok name -> name
  | Error message -> failwith message
;;
