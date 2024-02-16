# Discussion 4 - Friday, February 16th

## Reminders

1. Quiz 2 next **Friday, February 23rd**
   1. More info: [@409](https://piazza.com/class/lrf5qvp042i1y2/post/409)
3. Project 2 released, due **February 27th @ 11:59 PM**
   1. More info + FAQs: [@384](https://piazza.com/class/lrf5qvp042i1y2/post/384)

## Notes

- OCaml [`map`](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d4_hof#part-1-map) and [`fold`](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d4_hof#part-2-fold) review
- OCaml records
- OCaml types & variants

## Exercises

### Higher Order Functions (Map & Fold)

Consider the following higher order functions:

```ocaml
let rec map f xs =
  match xs with
    | [] -> []
    | h::t -> (f h)::(map f t)

let rec fold f a lst =
  match lst with
    | [] -> a
    | h::t -> fold f (f a h) t

let rec fold_right f lst a =
  match lst with
    | [] -> a
    | h::t -> f h (fold_right f t a)
```

Write the following functions using either `fold`, `fold_right`, and / or `map`:

#### `list_add x nums`

- **Type**: `int -> int list -> int list`
- **Description:** Given a number `x` and a list of integers `nums`, return `nums` with all of its values incremented by `x`.
- **Examples:**

```ocaml
list_add 1 [1;2;3;4] = [2;3;4;5]
list_add 3 [1;2;3;4] = [4;5;6;7]
list_add 1 [] = []
list_add (-3) [7;10] = [4;7]
```

#### `mold f lst`

- **Type**: `('a -> 'b) -> 'a list -> 'b list`
- **Description:** Rewrite the `map` function using `fold`
- **Examples**:

```ocaml
mold (fun x -> x = 3) [1;2;3;4] = [false;false;true;false]
mold (fun x -> x - 1) [1;2;3;4] = [0;1;2;3]
mold (fun x -> 0) [1;2;3;4] = [0;0;0;0]
mold (string_of_int) [1;2;3;4] = ["1";"2";"3";"4"]
```

- **Addendum:** What happens if we use `fold_right` instead of `fold`? How does this affect the order of iteration?

#### `list_sum_product lst`

- **Type**: `int list -> int * int * bool`
- **Description**: Write a function that takes in an `int list` and returns an `int * int * bool` tuple of the following form:
  - The first element is the **sum** of the **even** indexed elements
  - The second element is the **product** of the **odd** indexed elements.
  - The third element is a boolean that will be **true** if the sum and the product are equal, otherwise **false**.
- **Note:** The list is 0 indexed, and 0 is an even index.
- **Examples**:

```ocaml
list_sum_product [] = (0,1,false)
list_sum_product [1;2;3;4] = (4,8,false)
list_sum_product [1;5;4;1] = (5,5,true)
list_sum_product [1;-2;-3;4] = (-2,-8,false)
```

### Records

Consider the following custom record type, which is similar to the return tuple of `list_sum_product`:

```ocaml
type results = {
  sum_even: int;
  product_odd: int;
  num_elements: int;
}
```

#### `record_sum_product lst`

- **Type**: `int list -> results`
- **Description**: Similar to the `list_sum_product` function above, but returns a `results` record with the following fields:
  - `sum_even` is the **sum** of the **even indexed** elements
  - `product_odd` is the **product** of the **odd indexed** elements.
  - `num_elements` is the number of elements in `lst`
- **Note:** The list is 0 indexed, and 0 is an even index.
- **Examples**:

```ocaml
record_sum_product [] = {sum_even = 0; product_odd = 1; num_elements = 0}
record_sum_product [1;2;3;4] = {sum_even = 4; product_odd = 8; num_elements = 4}
record_sum_product [1;5;4;1] = {sum_even = 5; product_odd = 5; num_elements = 4}
record_sum_product [1;-2;-3;4] = {sum_even = -2; product_odd = -8; num_elements = 4}
```

### Variant Types

Let's build a custom binary `tree` data type in OCaml! First, we will define the `tree` type:

```ocaml
type 'a tree =
  | Leaf
  | Node of 'a tree * 'a * 'a tree
```

This recursively defines a `tree` to either be a:

- `Leaf`
- `Node` with a left sub-`tree`, a value, and a right sub-`tree`

#### `tree_add x tree`

- **Type**: `int tree -> int tree`
- **Description**: Given an `int tree`, return a new `int tree` with the same values in the old tree incremented by `x`.
- **Examples**:

  ```ocaml
  let tree_a = Node(Node(Leaf, 5, Leaf), 6, Leaf)
  let tree_b = Node(Node(Leaf, 4, Leaf), 5, Node(Leaf, 2, Leaf))

  tree_add 1 tree_a = Node(Node(Leaf, 6, Leaf), 7, Leaf)
  tree_add 5 tree_b = Node(Node(Leaf, 9, Leaf), 10, Node(Leaf, 7, Leaf))
  ```

#### `tree_preorder tree`

- **Type**: `string tree -> string`
- **Description**: Given a `string tree`, return the preorder concatenation of all the strings in the tree.
- **Examples**:

  ```ocaml
  let tree_c = Node(Node(Leaf, " World", Leaf), "Hello", Node(Leaf, "!", Leaf))
  let tree_d = Node(Node(Node(Leaf, " super", Leaf), " is", Node(Leaf, " easy!", Leaf)), "Recursion", Node(Leaf, " 💀", Leaf))

  tree_preorder tree_c = "Hello World!"
  tree_preorder tree_d = "Recursion is super easy! 💀"
  ```

#### `tree_sum_product tree`

- **Type**: `int tree -> int * int`
- **Description**: Given an `int tree`, return an `int * int` tuple of the following form:
  - The first element is the **sum** of **all** numbers in the tree
  - The second element is the **product** of **all** numbers in the tree
- **Examples**:

  ```ocaml
  let tree_a = Node(Node(Leaf, 5, Leaf), 6, Leaf)
  let tree_b = Node(Node(Leaf, 4, Leaf), 5, Node(Leaf, 2, Leaf))

  tree_sum_product tree_a = (11, 30)
  tree_sum_product tree_b = (11, 40)
  ```

## Resources & Additional Readings

- [Spring 2023 OCaml HOF discussion](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d4_hof)
- [Spring 2023 Project Review](https://github.com/cmsc330-umd/spring23/tree/main/discussions/d5_project_review)
- [Fall 2023 OCaml HOF discussion](https://github.com/cmsc330fall23/cmsc330fall23/tree/main/discussions/d6_ocaml_hof)
- [Fall 2023 Python HOF + Regex discussion](https://github.com/cmsc330fall23/cmsc330fall23/tree/main/discussions/d2_hof_regex)
- [Anwar's Imperative OCaml Slides](https://bakalian.cs.umd.edu/assets/slides/10-imperative.pdf)
