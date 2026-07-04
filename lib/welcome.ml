open! Core

let message username =
  sprintf "Welcome, %s!" (Username.to_string username)
