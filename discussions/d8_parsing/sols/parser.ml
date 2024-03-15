open Lexer

(* Types *)
type expr =
| Int of int
| Plus of expr * expr
| Mult of expr * expr

(* Provided helper function - takes a token list and an exprected token.
 * Handles error cases and returns the tail of the list *)
let match_token (toks : token list) (tok : token) : token list =
  match toks with
  | [] -> raise (Failure(string_of_token tok))
  | h::t when h = tok -> t
  | h::_ -> raise (Failure( 
      Printf.sprintf "Expected %s from input %s, got %s"
        (string_of_token tok)
        (string_of_list string_of_token toks)
        (string_of_token h)
    ))

let lookahead toks = match toks with
   h::t -> h
  | _ -> raise (Failure("Empty input to lookahead"))


(* Parses a token list. *)
let rec parser (toks : token list) : expr =
  let (t, exp) = parse_S toks in
  if t <> [Tok_EOF] then
    raise (Failure "did not reach EOF")
  else
    exp

(* Parses the S rule. *)
and parse_S toks = 
  let (t, m) = parse_M toks in
  match lookahead t with
  | Tok_Plus -> let t' = match_token t Tok_Plus in
                let (t'', s) = parse_S t' in
                (t'', Plus (m, s))
  | _ -> t, m

(* Parses the M rule. *)
and parse_M toks =
  let (t, n) = parse_N toks in
  match lookahead t with
  | Tok_Mult -> let t' = match_token t Tok_Mult in
                let (t'', m) = parse_M t' in
                (t'', Mult (n, m))
  | _ -> t, n
            
(* Parses the N rule. *)
and parse_N toks =
  match lookahead toks with
  | Tok_Int i -> let t = match_token toks (Tok_Int i) in
                 (t, Int i)
  | Tok_LParen -> let t = match_token toks Tok_LParen in
                  let (t', s) = parse_S t in
                  let t'' = match_token t' Tok_RParen in
                  (t'', s)
  | _ -> failwith "parse_N failed"
