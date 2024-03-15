# Discussion 8 - Friday, March 15th

## Reminders

1. Project 3 due **tonight! March 15th @ 11:59 PM**
1. Have a good spring break!

## Coding Exercise

- To go from source code to a running program, there are 3 steps (at least for our purposes):

  - Tokenizing/Lexing (separating text into smaller tokens)
  - Parsing (generating something meaningful from the tokens - an AST)
  - Interpreting (evaluating the result of the AST)

- Consider the following grammar:

  ```
  S -> M + S | M
  M -> N * M | N
  N -> n | (S)

  * where n is any integer
  ```

  - This grammar is right associative/recursive. Why did we provide a right associative grammar? What would you do if we didn't?.

  - What is the relative precedence of the + and \* operators here? How is it determined? How can we use CFGs to enforce precedence?

### Lexer

- Open `lexer.ml`.
- **NOTES:**
  - Take a look at the variant type `token` we have defined
  - Keep an index that keeps track of where we are in the string, and move forward as we keep tokenizing.
  - It's probably also a good idea to just define all the regex's and store in variables at the top.

### Parser

- Open `parser.ml`.
- **NOTES:**
  - Take a look at the variant type `expr` we have defined
  - Use `let rec ... and` to write mutually recursive functions.
  - `lookahead` returns the head of the list.
  - `match` "consumes" the head of the list (provided that the token and head of the list match).
- **IMPORTANT:**
  - We're going to write a function named `parse_X` for each nonterminal `X` in our grammar.
  - Each of these functions will parse (consume) some tokens, and return (1) the unparsed tokens and (2) the AST which corresponds to the parsed tokens.

### Interpreter

- Open `interpreter.ml`.
- **NOTES:**
  - Our `eval` function will take in an AST created by `parser` and evaluate it into an integer
  - Recursion is your friend!

## Resources & Additional Readings

- [Cliff's Notes on Grammars](https://bakalian.cs.umd.edu/assets/notes/grammars.pdf)
- [Anwar's Parsing Slides](https://bakalian.cs.umd.edu/assets/slides/16-parsing1.pdf)
