open Parser

(* Evaluater *)

let rec eval (ast : expr) : int =
  match ast with
  | Int x -> x
  | Mult (x, y) -> let x' = eval x in
                   let y' = eval y in
                   x' * y'
  | Plus (x, y) -> let x' = eval x in
                   let y' = eval y in
                   x' + y'
