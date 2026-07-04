open! Core
open Notty
open Bonsai_term

module Attr = struct
  (** [Bonsai_term.Attr.t] is [Notty.A.t] in [bonsai_term]. *)
  external to_view : A.t -> Attr.t = "%identity"
end

let rec row_to_view = function
  | Operation.End -> View.none
  | Skip (width, rest) ->
    View.hcat
      [ View.transparent_rectangle ~width ~height:1
      ; row_to_view rest
      ]
  | Text (attr, text, rest) ->
    View.hcat
      [ View.text ~attrs:[ Attr.to_view attr ] (Text.to_string text)
      ; row_to_view rest
      ]
;;

let of_image image =
  let width = I.width image in
  let height = I.height image in
  if width <= 0 || height <= 0
  then View.none
  else (
    Operation.of_image (0, 0) (width, height) image
    |> List.map ~f:row_to_view
    |> View.vcat)
;;
