# Project 6: the-rust-project-for-introducing-330-students-to-basic-syntax-and-semantics

>[!IMPORTANT]
> **Due**: Wed May 1
> 
> **Points**: 50 public, 50 semipublic
>
> Project 7 will take a lot of time, and was released concurrently with this project. Please aim to finish well before the due date.

## Introduction

In this project, we will implement some common (and some uncommon) functions in
Rust in order to get used to the language. Rust has an emphasis on safety, which
will change functionality. By the end of this project, you will be familiar with
this.

> [!NOTE]
> For some functions, you will see `impl IntoIterator`, or other `impl` statements.
> These act similarly to implementing an interface in Java, as you saw in
> 131/132. They just refer to any type that has certain properties, in the `intoIterator` case, types that be iterated over. See the
> documentation of [`IntoIterator`](https://doc.rust-lang.org/stable/core/iter/trait.IntoIterator.html)
> and [`Iterator`](https://doc.rust-lang.org/stable/core/iter/trait.Iterator.html)
> for more details.

### Ground Rules

This is an individual assignment. You may use functions found in Rust's standard
library. You may write any helper functions that you wish. You may also use the [`regex` crate](https://docs.rs/regex/latest/regex/).
You may not use `unsafe`.

> [!TIP]
> With the help of the standard library, many of these functions will become easier. Consider looking through [the docs](https://doc.rust-lang.org/std/index.html). 
> However, you will get more practice with Rust if you implement them manually. Either is fine for this project, it is up to you. 

### Testing and Submitting

Like OCaml, Rust uses the `build` and `test` commands. However, rather than
`dune`, we use `cargo`.



 - To build your project, run `cargo build`.
 - To run the public tests, run `cargo test`.
 - To get suggestions on various ways to improve your code, run `cargo clippy`.
 - To format your code, run `cargo fmt`.

When running tests, you will see a list of tests, and whether or not you passed: 
```rust 
test test_double_up_and_dance ... ok
test test_double_up_and_dance2 ... ok
test test_gauss ... FAILED
test test_in_range1 ... ok
test test_gauss2 ... FAILED
test test_in_range2 ... ok
```

`ok` means you passed. Good job! `FAILED` means that there is an issue. If this
is the case, you will see an output beneath the failed test: 

```rust
---- test_gauss stdout ----
thread 'test_gauss' panicked at tests/public.rs:9:5:
assertion `left == right` failed
  left: Some(2)
 right: Some(1)
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

> [!IMPORTANT]
> `left` is YOUR output. `right` is the EXPECTED output.


There is no equivalent to running `dune utop src` for this project.

You can write your own tests: any function with the `#[test]`
attribute, and any documentation tests are run automatically with the command `cargo test`.

For this project, we include the public tests as unit tests in the bottom of your lib.rs file.

Rust also supports documentation tests. We have included one example above `gauss()`. These are tests within the comments above functions.
The Rust Book is a great resource if you would like more information about [how document/unit tests work](https://doc.rust-lang.org/stable/cargo/commands/cargo-test.html).

You can also try your Rust code online at <https://play.rust-lang.org/>.



Remember that Rust has print statements that will appear in the console.
You may wish to take advantage of these for debugging:

- [`println!`](https://doc.rust-lang.org/std/macro.println.html)/[`eprintln!`](https://doc.rust-lang.org/std/macro.eprintln.html)
- [`dbg!`](https://doc.rust-lang.org/std/macro.dbg.html)'

If you liked using `gdb` or `lldb` with C code in CMSC216, those also work with Rust.
Follow [this guide](https://blog.logrocket.com/debugging-rust-apps-with-gdb/#rustgdbexample).

## Part (A): Basic Functions

To get familiar with the syntax, we will start with some basic functions.
Implement the following:

### `pub fn gauss(n: i32) -> Option<i32>`

This function sums the numbers from 1 to n, where n is an arbitrary positive
integer. It will return the integer given by 1 + 2 + 3 + ... + `n`. If `n` ≤ 0,
return `None`.

We will not test your code with numbers large enough to risk overflow.

#### Examples

```rust
assert_eq!(gauss(10), Some(55));
assert_eq!(gauss(-2), None);
assert_eq!(gauss(1), Some(1));
assert_eq!(gauss(0), None);
assert_eq!(gauss(19), Some(190));
```

### `pub fn double_up_and_dance(slice: &[i32]) -> Vec<i32>`

This function takes in a reference to a [slice](https://doc.rust-lang.org/std/primitive.slice.html)
of integers as input. A slice resembles arrays in other languages; its a homogenous list of fixed size.

You should perform the following operations:

- Create a new [`Vec`](https://doc.rust-lang.org/std/vec/struct.Vec.html) with
  the same elements as the slice, but repeated twice. For example, `[1, 3, 2]`
  should become `[1, 1, 3, 3, 2, 2]`.
- If the vector ends up having 5 entries, take the second (index 1) element of the **slice**, and add it onto the fifth (index 4) element of the **vec**. Thus, using the same example as above, 
  `[1, 1, 3, 3, 2, 2]` becomes `[1, 1, 3, 3, 5, 2]`
- Return the vec.

#### Examples

```rust
assert_eq!(double_up_and_dance(&[1, 2, 3]), [1, 1, 2, 2, 5, 3]); // 2 (the second element of original slice) is added to the the 3 that was in the 5th element of the vector, yeilding 5

assert_eq!(double_up_and_dance(&[-9, 7]), [-9, -9, 7, 7]);
assert_eq!(double_up_and_dance(&[42, 42]), [42, 42, 42, 42]);
assert_eq!(double_up_and_dance(&[]), []);
assert_eq!(double_up_and_dance(&[3, 2, 3, 7, 8]), [3, 3, 2, 2, 5, 3, 7, 7, 8, 8]);
```

### `pub fn to_binstring(n: u32) -> String`

This function takes in an unsigned integer (i.e. a positive integer) and
converts it to the equivalent binary string. You should not pad with leading
zeros, except for `0` which should become the string `"0"`.


#### Examples

```rust
assert_eq!(to_binstring(0), "0");
assert_eq!(to_binstring(2), "10");
assert_eq!(to_binstring(9), "1001");
assert_eq!(to_binstring(32), "100000");
assert_eq!(to_binstring(510), "111111110");
assert_eq!(to_binstring(0b1101), "1101");
```

### `pub fn in_range(items: impl IntoIterator<Item = i32>, range: Range<i32>) -> usize`


This function takes in a value that can be converted into an iterator of
integers (slice, vector, etc.), and counts how many elements in the iterator are within the given
range **in terms of value**. That is, given the range 2-6, how many of the entries are numbers between 2 and 6? The list you are given is
not necessarily sorted.

[`Range`](https://doc.rust-lang.org/stable/std/ops/struct.Range.html)
is a range of values. It is created using `start..end` syntax. `start` is
included in the range, but `end` is not. For example, `2..6` denotes a range from 2 (inclusive) to 6 (exclusive).


There are two approaches to implementing this function.

- Imperative/C style: use a `for` loop to iterate over the `items`.
- Functional/OCaml style: use the [`into_iter()`](https://doc.rust-lang.org/std/iter/trait.IntoIterator.html#tymethod.into_iter)
method to convert `items` into an [`Iterator`](https://doc.rust-lang.org/std/iter/trait.Iterator.html),
and then use that trait's methods.

#### Examples

```rust
assert_eq!(in_range([5, 2, 1, 3, 9, 6], 2..6), 3);
assert_eq!(in_range(vec![5, 2, 1, 3, 9], 3..5), 1); //vector, rather than a slice. Can still be iterated over!
assert_eq!(in_range([5, 2, 1, 3, 9], 2..11), 4);
assert_eq!(in_range([], 2..11), 0);
```

## Part (B): Complex Functions

### `pub fn capitalize_words<'a>(words: impl IntoIterator<Item = &'a mut String>)`

Given an iterator over mutable strings, this function will capitalize the
**first letter** of each word in the iterator. Note that this function returns a
unit type. You must modify the `String`s **in place**. You may assume that you
will not be asked to capitalize numbers or special characters; inputs are
guaranteed to start with an ASCII letter.

#### Examples

```rust
let mut list = ["hello".to_owned(), "world".to_owned()];
capitalize_words(&mut list);
assert_eq!(list, ["Hello", "World"]);

let mut list = ["cmsc330".to_owned(), "is".to_owned(), "great".to_owned()];
capitalize_words(&mut list);
assert_eq!(list, ["Cmsc330", "Is", "Great"]);
```

### `pub fn read_prices(filename: &str) -> Option<HashMap<String, u32>>`

Given a txt file, parse and return the items sold by a vending machine, along
with their prices. Alternatively, return `None` if the file has an invalid
format.

Each line of the the file must either be a price listing or a comment.

- Price listings consist of the following in the order shown:
  - an item name (starts with an uppercase (`A`-`Z`) or
  lowercase (`a`-`z`) letter, followed by any number of such letters or space characters)
  - a semi-colon `;`
  - a price in cents (any integer)
  - `c` or `cents`.
  - **Each of these can be separated by an arbitrary number of spaces. That
    includes 0 spaces. These should not be included in your hashmap.** (You may assume no spaces at the very beginning of a line.)
- Comment lines start with `;` and can contain any characters after that. They should be ignored.


#### Validity: 
An item's price must be between 1 and 50 cents (inclusive). An
item must appear at most once in the file, duplicates are not allowed.
If any of these rules are violated, or if any line has an invalid format,
you must return `None`.

You can use the [`regex` crate](https://docs.rs/regex/latest/regex/) to implement the rules above.

#### Example Files

```text
;file1.txt
; sweet
ice cream; 10 cents
; savory
sandwich;49c
hot dog ; 49 c
```

```text
;file2.txt
;icecream;10cents
ice cream; 10     cents

; lines below are invalid
goldfish; 100c
sandwich;  49c cents
```

```text
;file3.txt
cat   ; cats are not snacks
chips ; 20c
```

Given this file, your function will read through the information and create a
`HashMap`. In this, you will store the string representing the item's name, as
well as the integer representing its price. If a file is empty, or contains just
comments, just return an empty `HashMap`, not `None`.


In addition to the regex crate, a helpful resource for this is [BufReader](https://doc.rust-lang.org/std/io/struct.BufReader.html)
which can be used read the file input into lines.
You can assume that I/O operations succeed, so feel free to `.unwrap()`
any `io::Result`s.

#### Example

```rust
assert_eq!(
    read_prices("inputs/file1.txt"),
    Some(HashMap::from([
        ("ice cream".to_owned(), 10),
        ("sandwich".to_owned(), 49),
        ("hot dog".to_owned(), 49)
    ]))
);
assert_eq!(read_prices("inputs/file2.txt"), None);
assert_eq!(read_prices("inputs/file3.txt"), None);
```
