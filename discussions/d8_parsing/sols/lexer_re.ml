(* Type *)
type token =
| Tok_Int of int
| Tok_Mult
| Tok_Plus
| Tok_LParen
| Tok_RParen
| Tok_EOF

let string_of_token tok = match tok with
| Tok_Int(i) -> string_of_int i
| Tok_Mult -> "*"
| Tok_Plus -> "+"
| Tok_LParen -> "("
| Tok_RParen -> ")"
| Tok_EOF -> ""

let rec string_of_list conv lst = 
match lst with
| [] -> ""
| h::[] -> conv h
| h::t -> (conv h) ^ " " ^ (string_of_list conv t)

(* Given source code returns a token list. *)
let rec lexer (input : string) : token list =
  let len = String.length input in

  let numre = Re.compile (Re.Perl.re "^(-?[0-9]+)") in
  let addre = Re.compile (Re.Perl.re "^\+") in
  let mulre = Re.compile (Re.Perl.re "^\*") in
  let lpre = Re.compile (Re.Perl.re "^\(") in
  let rpre = Re.compile (Re.Perl.re "^\)") in
  let wsre = Re.compile (Re.Perl.re "^(\s+)") in

  if input = "" then []
  else if Re.execp lpre input then
    Tok_LParen::(lexer (String.sub input 1 (len - 1)))
  else if Re.execp rpre input then
    Tok_RParen::(lexer (String.sub input 1 (len - 1)))
  else if Re.execp addre input then
    Tok_Plus::(lexer (String.sub input 1 (len - 1)))
  else if Re.execp mulre input then
    Tok_Mult::(lexer (String.sub input 1 (len - 1)))
  else if Re.execp numre input then
    let numgroup = Re.exec numre input in
    let num = Re.Group.get numgroup 1 in
    let numlen = String.length num in
    let numint = int_of_string num in
    Tok_Int(numint)::(lexer (String.sub input numlen (len - numlen)))
  else if Re.execp wsre input then 
    let wsgroup = Re.exec wsre input in 
    let ws = Re.Group.get wsgroup 1 in 
    let wslen = String.length ws in
    (lexer (String.sub input wslen (len - wslen)))
  else
    failwith "lexing error"
;;