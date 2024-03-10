# Solutions

## Exercise 1

- S -> S + S -> S + S + S -> 1 + S + S -> 1 + 2 + S -> 1 + 2 + 3
- S -> S + S -> 1 + S -> 1 + S + S -> 1 + 2 + S -> 1 + 2 + 3 works too

**NOTE:** If there are 2 leftmost derivations or 2 rightmost for the same string, what does that mean? The grammar is ambiguous.

- To show that a grammar is ambiguous, show 2 different leftmost or rightmost derivations for the same string.
- You must give 2 leftmost or 2 rightmost derivations, not one leftmost and one rightmost
- It's hard to know whether a grammar is ambiguous or not, but be suspicious if you see something along the lines of S -> SS, S -> SSS, S -> S+S, etc.

## Exercise 2

- `S -> T -> bT -> bU -> b`
- `S -> aS -> aT -> aU -> acU -> ac`
- `S -> T -> bT -> bbT -> bbU -> bbcU -> bbc`

---

- Regex: `a*b*c*`

---

```
S -> Sc | T
T -> Tb | U
U -> Ua | ε
```

## Exercise 3

- Grammar 3
- Grammar 2
  ```
  S -> ASB -> aASB -> aaASB -> aaaSB -> aaacB -> aaac
  S -> ASB -> aASB -> aaSB -> aaASBB -> aaaSBB -> aaacBB -> aaacB -> aaac
  ```

## Exercise 4

```
S -> aSbb | ε
```

---

```
S -> aSbbb | T
T -> bT | ε
```

## Exercise 5

No
