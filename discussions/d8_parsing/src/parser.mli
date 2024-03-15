type expr =
| Int of int
| Plus of expr * expr
| Mult of expr * expr

val parser : Lexer.token list -> expr
val parse_S : Lexer.token list -> Lexer.token list * expr
val parse_M : Lexer.token list -> Lexer.token list * expr
val parse_N : Lexer.token list -> Lexer.token list * expr