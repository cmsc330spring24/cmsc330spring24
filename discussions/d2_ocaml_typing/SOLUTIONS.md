# Solutions

## Question \#1

```ocaml
let rec remove_all lst x = match lst with
    | [] -> []
    | h::t -> if x = h then (remove_all t x) else h::(remove_all t x);;
```

```ocaml
let index_of lst x = 
    let rec helper lst x i = match lst with
    | [] -> -1
    | h::t -> if x = h then i else (helper t x (i + 1)) 
in helper lst x 0;;
```

## Question \#2

```ocaml
[1a] 'a -> 'a -> bool

[1b] int -> int -> bool

[1c] int -> int -> string -> int

[1d] int -> int -> bool -> int

[1e] int -> int -> bool -> int list

[1f] (float -> bool) -> float -> float -> bool

[1g] bool -> int -> int -> int -> int
```

## Question \#3

```ocaml
[2a] (1, [true])
(* NOTE: same thing as `int * (bool list)` *)

[2b] fun (a, b) c d -> [a + 1 = c; b +. 1.0 = d]

[2c] fun a b -> (int_of_float a, b = "a")

[2d] fun f a -> [f a; a = 2]

[2e] fun f a -> (a, [f a])

[2f] fun f g a -> g (f a)

[2g] fun a b c -> if (a = c && b = []) then (a,a) else (c,c)
```

## Question \#4

```ocaml
('a -> 'b -> 'c) -> ('a * 'a) list -> 'b list -> ('c * 'c) list
```

## Question \#5

1. two
2. three
3. three