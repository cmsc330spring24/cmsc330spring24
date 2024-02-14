# Project 2: HOFs on trees & Database design
Due: Tuesday, Feburary 27 11:59 PM (Late: Wednesday, Feburary 28 11:59 PM)

Points: 40% public, 30% semipublic, 30% secret

**This is an individual assignment. You must work on this project alone.**

## Introduction
The goal of this project is to increase your familiarity with programming in Ocaml and give you more practice with higher order functions and user-defined types. You will write a number of small functions that will use higher order functions operating over a tree structure, and then you will implement a program that simulates a database.

### Ground Rules
In addition to your own code, you may use library functions found in the [`Stdlib` module](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Stdlib.html) and the `List` module. You **may not** (under threat of a grading penalty) use any other submodules of `Stdlib` or any imperative features of Ocaml unless otherwise stated.

### Testing & Submitting
Submit by running `submit`after pushing your code to GitHub. 

To test locally, run `dune runtest -f`. Besides the provided public tests, you will also find the file `student.ml` in `test/student/`, where you'll be able to add `OUnit` tests of your own. More detailed information about writing tests can be found [here](https://www.youtube.com/watch?v=C36JnAcClOQ).

You can interactively test your code by running `dune utop src`, which will include your source files. (As usual, all of your commands in `utop` need to end with two semicolons (`;;`), otherwise it will appear as if your terminal is hanging)

## Part 1: Database Design

Create a program that stores `person`s in a database which can later be queried. 
A person is defined as a record as follows:

```ocaml
type person = { name: string;
                age: int;
                hobbies: string list }
```

You must come up with your own implementation for the data type for the database `db`. As provided above, `person` includes `name`, `age`, and `hobbies`, which is the data we would like to add to our database.

Given a piece of data like `person`, you will implement the following operations on the database:

### `newDatabase`
  - **Type**: `db`
  - **Description**: creates and returns an empty database

### `insert person database`: 
  - **Type**: `person -> db -> db`
  - **Description**: given a person and a database, insert the person into the database and return the updated database. If the person already exists in the database, there should be duplicate entries of the person after performing the insert function.
  - **Examples**:
  ```ocaml
  let db1 = insert {name="Alice"; age=23; hobbies=["Skiing";"golfing"]} newDatabase
  let db1 = insert {name="Alice"; age=23; hobbies=["Skiing";"golfing"]} db1
  (* db1 stores a database that includes Alice twice, so querying the size of this database should result in 2 instances of the Alice person *)
  ```

### `remove name database`: 
  - **Type**: `string -> db -> db`
  - **Description**: given a person's name and a database, remove all `person`s with the same name from the database and return the updated database. If no `person`s exist in the database with the same name as the given string, the database should not change.
  - **Examples**:
  ```ocaml
  let db1 = remove "Alice" db1
  (* db1 no longer contains Alice, db1 is now empty *)
  ```

#### Comparator
A comparator is a function that tells how to compare two people. It will be used in the `sort` function.
Its type is `person -> person -> int`. It follows the typical -1, 0, 1 convention. Below is an example comparator:
  ```ocaml
  let comparator1 p1 p2 = 
    if p1.age < p2.age then -1
    else if p1.age == p2.age then 0
    else 1
  ```

### `sort comparator db`:
  - **Type**: `(person -> person -> int) -> db -> person list`
  - **Description**: given a comparator function and a db, sort the list of people based on the comparator and return in the form of a person list. You may use anything from the `Stdlib` or the `List` modules to help you.
   - **Examples**:
  ```ocaml
  let db1 = insert {name="Alice"; age=23; hobbies=["Skiing"; "golfing"]} newDatabase

  let db2 = insert {name="Bob"; age=42; hobbies=["Skiing"; "Cooking"; "Legos"]} db1

  sort comparator1 db2 = [{name="Alice"; age=23; hobbies=["Skiing"; "golfing"]}; {name="Bob"; age=42; hobbies=["Skiing"; "Cooking"; "Legos"]}]
  ```

#### Aside

When we are describing something we typically link together and modify different 
descriptors with common words like *and*, *or*, *not*. For example: "His name 
is Cliff AND he is older than 18 AND (he likes Lego OR he likes chocolate)." 
The parentheses are added to remove ambiguity. By defining words
like *and* and *or* to link exactly 2 parts, we can figure out exactly which 
parts are under the *and* condition and which are under the *or* condition. 
Visually this looks like:
```text
and(e1, e2)
or(e1, e2)

and(name is cliff, and(older than 18, or(likes Lego, likes Chocolate)))
```

The nice part about this modified English grammar/syntax is that we don't have 
ambiguity and it's easy to represent this as code. See below.

#### Condition
A `condition` is a restriction on the combination of age, name, and/or hobbies. We represent a condition as a type containing either a true/false value, a restriction on age, name, or hobbies, or a logical operator that contains other conditions. The `condition` type will look like this:
```ocaml
type condition = 
  | True
  | False
  | Age of (int -> bool)
  | Name of (string -> bool)
  | Hobbies of (string list-> bool)
  | And of condition * condition
  | Or of condition * condition
  | Not of condition
  | If of condition * condition * condition
```

Assume that conditions assigned to `True` will always evaluate to `true` and `False` will evaluate to `false`. For example, if I wanted to get a list of people who are over 30 **and** have the name "Bob", our condition would look like this:
```ocaml
  let condition1 = And(Age(fun age -> age > 30), Name(fun name -> name = "Bob"));;
```
Other examples of valid `condition`s are:
```ocaml
  False

  Name(fun name -> name = "Alice")

  Not((Age(fun age -> a < 30)))

  If(True,Age(fun age -> a < 30),Name(fun name -> name = "Bob"))
  (* if true then Age else Name *)

  Or(True,Hobbies(fun hobbies -> false))
```


### `query condition db`:
  - **Type**: `condition -> db -> person list`
 - **Description**: given a condition and a database, return a list of all entries in the database that satisfy the condition.
 - **Examples**:
  ```ocaml
  let db1 = insert {name="Alice"; age=23; hobbies=["Skiing"; "golfing"]} newDatabase

  let db2 = insert {name="Bob"; age=42; hobbies=["Skiing"; "Cooking"; "Legos"]} db1

  query condition1 db2 = [{name="Bob";age=42;hobbies=["Skiing";"Cooking"; "Legos"]}]

  query True db2 = db2
  query False db2 = []
  ```
   
### `queryBy condition database comparator`:
   - **Type**: `condition -> db -> comparator -> person list`:
   - **Description**: given a condition, a database, and a comparator, return a list of all entries in the database that satisfy that query, that is sorted by the comparator function
   - **Examples**:
   ```ocaml
   let comparator1 p1 p2 = 
    if p1.age < p2.age then -1
    else if p1.age == p2.age then 0
    else 1

   condition2 = Age(fun age -> age < 90)

   queryBy condition2 db2 comparator1 = [{name="Alice";age=23;hobbies=["Skiing";"golfing"]}; {name="Bob";age=42;hobbies=["Skiing";"Cooking"; "Legos"]}]
   ```

### `update condition db personData`
  - **Type**: `condition -> db -> (person -> person) -> db`  
  - **Description**: given a condition, a database, and a function that will return a person with updated data given a person, update every person in the database that satisfies the `condition` using `personData`
  - **Examples**: 
  ```ocaml
  let change1 = fun person -> { name = person.name; age = person.age; hobbies = "Pickleball"::person.hobbies}

  update condition1 db2 change1
  (* Bob's hobbies are now updated to include pickleball *)
  ```

### `deleteAll condition db`
  - **Type**: `condition -> db -> db` 
  - **Description**: given a condition and a database, delete all entries
   in the database that satisfy the query
  - **Examples**: 
  ```ocaml
  deleteAll condition1 db2
  (* Bob is deleted from our database *)
  ```

## Part 2: Binary Trees

***This part is independent of Part 1***

Given the type of a binary tree

```ocaml
type 'a tree =
  | BiNode of 'a tree * 'a * 'a tree
  | Leaf
```

and the type of `'a flat`:
```ocaml
type 'a flat = 
  | Lf 
  | Nd of 'a
```

Implement the following functions in `ntree.ml`:

### `flatten tree`
- **Type**: `'a tree -> 'a flat list`
- **Description**: Write a function `flatten`, which converts a binary tree into a `'a flat list` using [postorder traversal](https://lh6.googleusercontent.com/dyKoxSFKtdnpEVpNOV1_460ovzzLqcIe7rRplr6YrUheWqVJgtk9GztN-QHkvbxtJlDCo8_Y5NzLevE0dNxsitYjV0o3hUruNwcxYDteBGTzNg9knB0kfOMMmtY5B7Xrie2tnd86). 
  - **Examples**: Given a binary tree `t`:
  ```ocaml
                100
               /   \
             /       \
           Leaf      200
                     /  \
                   /      \
                 /         \
               100         300
              /   \        /  \
            Leaf  Leaf   Leaf  Leaf
  ```
  ``` ocaml
  let t =
    BiNode
      (Leaf, 100, BiNode (BiNode (Leaf, 100, Leaf), 200, BiNode (Leaf, 300, Leaf)))
  ```

  ```ocaml
  let fl = flatten t;;
  'a flat list: [Lf; Lf; Lf; Nd 100; Lf; Lf; Nd 300; Nd 200; Nd 100]
  ```

  ```ocaml
  let t1 = BiNode (BiNode (Leaf, "CMSC", Leaf), "330", BiNode (Leaf, "!", Leaf)) in
  let t2 = BiNode (BiNode (BiNode (Leaf, 3.0, Leaf), 2.0, Leaf), 1.0, Leaf) in
  let t3 = BiNode (Leaf, 4, BiNode (BiNode (Leaf, 6, Leaf), 5, Leaf)) in

  flatten t1 = [Lf; Lf; Nd "CMSC"; Lf; Lf; Nd "!"; Nd "330"]
  flatten t2 = [Lf; Lf; Nd 3.0; Lf; Nd 2.0; Lf; Nd 1.0]
  flatten t3 = [Lf; Lf; Lf; Nd 6; Lf; Nd 5; Nd 4]
  ```
### `unflatten list`
- **Type**: `'a flat list -> 'a tree `
- **Description**: Write a function `unflatten`, which converts a `'a flat list` into a binary tree.
  - `unflatten fl` should return the binary tree `t` shown above in the diagram. 

**Note:** You should test your code by using the property:
```ocaml
assert (unflatten (flatten any_tree)) = any_tree (* returns a unit if successful *)
```
The `DebugUtils.gen_tree` function can generate random binary trees. For example:
```ocaml
DebugUtils.gen_tree ();;
- : int tree = BiNode (BiNode (Leaf, 59, Leaf), 72,
 BiNode (BiNode (Leaf, 2, Leaf), 375, BiNode (Leaf, 1, Leaf)))
```
You can generate random trees to test your `flatten` and `unflatten` functions using the following test:
```ocaml
let t = DebugUtils.gen_tree () in 
 assert (unflatten (flatten t) = t)
```
In Utop, you can generate random tress by running
```ocaml
dune utop src
DebugUtils.gen_tree ();;
```

## Part 3: n-ary Trees
In this section, we will extend the binary trees to trees with a variable number of chilren from 0 to n. Each node stores a data of type `'a` and a list of `'a tree`s. When this list is empty, then the Node is implicitly a leaf node. Note that leaf and inner nodes all contain data in this representation of a tree. 
- **Type**:
```ocaml
type 'a n_tree = Node of 'a * 'a n_tree list
```
Here is a tree that you can use for simple tests of your functions.
```ocaml
            "a"
          /     \
         /        \
       "b"        "g"
     /  |  \        \
  "c"  "d" "e"       "x"
        |
       "f"
```
```ocaml
let t =
  Node
    ( "a",
      [
        Node
          ( "b",
            [ 
              Node ("c", []); 
              Node ("d", [ Node ("f", []) ]); 
              Node ("e", []) 
            ]
          );
        Node ("g", [ Node ("x", []) ]);
      ] )
```

Implement the following functions in `ntree.ml`:

### `encode n_tree`
- **Type**: `'a n_tree -> ('a * int) list`
- **Description**: Write a function `encode`, which converts a `n_tree` into a list of tuples. The first element of the tuple is the data that is stored in the node, and the second is the number of immediate children. Follow [preorder traversal](https://lh5.googleusercontent.com/b9g2tL87bG9rK2JIMBbZUIVTev9yOmfeJlx8Y_pmUiVDSjpmeof97B6d6ok4p6qrwq8TX2NaRqJKo1uXcqxNGzuHhq4H3uSaICyJcb4ERwsxyF-YVy0Sakb2EjEqlGn__FG_Ml4k) to add elements to the list.
- **Examples**: 
```ocaml
let c = encode t;;
 (string * int) list =
[("a", 2); ("b", 3); ("c", 0); ("d", 1); ("f", 0); ("e", 0); ("g", 1); ("x", 0)]
```

### `decode list`
- **Type**: `('a * int) list -> 'a n_tree`
- **Description**: Write a function `decode` that takes a `('a * int) list` that encodes a tree and returns the corresponding `n_tree`. If the input list is empty, raise an `Invalid_arg` exception using `failwith` because an n_ary tree cannot represent a completely empty tree. 
- **Examples**: 
  `decode c` should return the n_ary tree `t` shown above. 

**Note**: You should test code your code by using the property:
```ocaml
assert (decode (encode any_tree) = any_tree) (* returns a unit if successful *)
```
The `DebugUtils.gen_ntree depth` function can generate random n-ary trees with a given depth. For example:
```ocaml
DebugUtils.gen_ntree 2;;
int n_tree =
Node (5,
 [Node (0, []); Node (0, []);
  Node (4, [Node (0, []); Node (0, []); Node (0, []); Node (0, [])]);
  Node (4, [Node (0, []); Node (0, []); Node (0, []); Node (0, [])]);
  Node (4, [Node (0, []); Node (0, []); Node (0, []); Node (0, [])])])
```

You can generate random trees to test your encode and decode functions using the following test:
```ocaml
let t = DebugUtils.gen_ntree 3 in 
 assert (decode (encode t) = t)
 ```
In Utop, you can generate random tress by running
```
dune utop src
DebugUtils.gen_ntree 2;;
```
- **Hint**:
  - Think about a "bottom-up" approach to this problem: decoding the leaf nodes first, then using those results to build the inner nodes and working your way up to the root node
  - Recall that leaf nodes have no children, so an encoded leaf node has a 0 as the second element of the tuple
  - Consider the tree given above:
    - Recognize this problem: in order to decode ("a", 2) we first need to decode its children ("b", 3) and ("g", 1); furthermore, in order to decode ("b", 3) we first need to decode its children ("c", 0), ("d", 1), and ("e", 0), and so on
    - A "bottom-up" approach would be to decode the leaf node ("c", 0) first
    - Then, decode leaf node ("f", 0)
      - Since the parent of ("f",0), the node ("d", 1), only has one child, we can now decode node ("d", 1) using the result of decoding leaf node ("f",0)
    - Then, decode leaf node ("e", 0)
      - Now, we have decoded all immediate children of node ("b", 3), and we can now decode node ("b", 3)
    - Next, decode the last leaf node ("x", 0)
      - The parent of ("x", 0), node ("g", 1) only has one child, so we can decode node ("g", 1)
    - Now, we have decoded all immediate children of root node ("a", 2), and we can now decode node ("a", 2)
    - We are done
