# Discussion 2 - Friday, February 2nd

## Reminders

1. Quiz 1 next **Friday, February 9th**
   1. Quizzes are 30 minutes long, and will start 10 minutes into discussion
3. Project 1 due **Sunday, February 11th @ 11:59 PM**
4. Quiz & Exam makeup policy: [@85](https://piazza.com/class/lrf5qvp042i1y2/post/85)
   1. Quiz makeups are held the **Tuesday** immediately following a quiz in **IRB 5165**
   1. Exam makeups are held the **Thursday** immediately following an exam in **IRB 5137**
   1. MUST submit documentation — see Piazza post for details

## Topics List

- Functional programming paradigms
- OCaml basics + HOFs
- OCaml typing & pattern matching basics

## Exercises

1. Write the following functions in OCaml **using recursion**:

   ### `remove_all lst x`

   - **Type:** `'a list -> 'a -> 'a list`
   - **Description:** Takes in a list `lst` and returns the list `lst` without any instances of the element `x` in the same order.

   ```ocaml
   remove_all [1;2;3;1] 1 = [2;3]
   remove_all [1;2;3;1] 5 = [1;2;3;1]
   remove_all [true; false; false] false = [true]
   remove_all [] 42 = []
   ```

   ### `index_of lst x`

   - **Type:** `'a list -> 'a -> int`
   - **Description:** Takes in a list `lst` and returns the index of the first instance of element `x`.
   - **Notes:**
     - If the element doesn't exist, you should return `-1`
     - You can write a helper function!

   ```ocaml
   index_of [1;2;3;1] 1 = 0
   index_of [4;2;3;1] 1 = 3
   index_of [true; false; false] false = 1
   index_of [] 42 = -1
   ```

2. Give the type for each of the following OCaml expressions:

   > **NOTE:** Feel free to skip around, there are a lot of examples! 🙃

   ```ocaml
   [2a] fun a b -> b < a

   [2b] fun a b -> b + a > b - a

   [2c] fun a b c -> (int_of_string c) * (b + a)

   [2d] fun a b c -> (if c then a else a) * (b + a)

   [2e] fun a b c -> [ a + b; if c then a else a + b ]

   [2f] fun a b c -> if a b != a c then (a b) else (c < 2.0)

   [2g] fun a b c d -> if a && b < c then d + 1 else b
   ```

3. Write an OCaml expression for each of the following types:

   ```ocaml
   [3a] int * bool list

   [3b] (int * float) -> int -> float -> bool list

   [3c] float -> string -> int * bool

   [3d] (int -> bool) -> int -> bool list

   [3e] ('a -> 'b) -> 'a -> 'a * 'b list

   [3f] ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c

   [3g] 'a -> 'b list -> 'a -> 'a * 'a
   ```

4. Give the type of the following OCaml function:

   ```ocaml
   let rec f p x y =
   match x, y with
      | ([], []) -> []
      | ((a,b)::t1, c::t2) -> (p a c, p b c)::(f p t1 t2)
      | (_, _) -> failwith "error";;
   ```

5. What values do `x`, `y`, and `z` bind to in the following code snippet?

   ```ocaml
   let x = match ("lol", 7) with
      | ("haha", 5)  -> "one"
      | ("lol", _)   -> "two"
      | ("lol", 7)   -> "three"
   ;;

   let y = match (2, true) with
      | (1, _)       -> "one"
      | (2, false)   -> "two"
      | (_, _)       -> "three"
      | (_, true)    -> "four"
   ;;

   let z = match [1;2;4] with
      | []           -> "one"
      | 2::_         -> "two"
      | 1::2::t      -> "three"
      | _            -> "four"
   ;;
   ```

More information + examples can be found in the [spring23 OCaml discussion](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d3_ocaml).

## Resources & Additional Readings

- Encouraged (but optional) readings
  - [Spring 2023 OCaml Discussion](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d3_ocaml)
  - [cs3110 - Expressions in OCaml](https://cs3110.github.io/textbook/chapters/basics/expressions.html)
- OCaml typing / expression generators
  - https://nmittu.github.io/330-problem-generator/type_of_expr.html
  - https://nmittu.github.io/330-problem-generator/expr_of_type.html
