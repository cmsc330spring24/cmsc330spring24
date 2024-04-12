# Discussion 11 - Friday, April 12th

## Reminders

- Project 5 released, due **Tuesday, April 23rd at 11:59 PM**
  - FAQ & Details: [@1712](https://piazza.com/class/lrf5qvp042i1y2/post/1712)

## Lambda Calculus Notes

### Call by Value

> _"eager evaluation"_

Before doing a beta reduction, we make sure the argument cannot, itself, be further evaluated:

```scheme
(λz. z) ((λy. y) x) →
(λz. z) x →
x
```

### Call by Name

> _"lazy evaluation"_

We can specifically choose to perform beta-reduction _before_ we evaluate the argument:

```scheme
(λz. z) ((λy. y) x) →
(λy. y) x →
x
```

## Exercises

**Make the parentheses explicit in the following expressions:**

1. `a b c`

2. `λa. λb. c b`

3. `λa. a b λa. a b`

**Identify the free variables in the following expressions:**

4. `λa. a b a`

5. `a (λa. a) a`

6. `λa. (λb. a b) a b`

**Apply alpha-conversions to the following:**

7. `λa. λa. a`

8. `(λa. a) a b`

9. `(λa. (λa. (λa. a) a) a)`

**Apply beta-reductions to the following:**

10. `(λa. a b) x b`

11. `(λa. b) (λa. λb. λc. a b c)`

12. `(λa. a a) (λa. a a)`

**Consider the following subset of the church encodings:**

$$
\begin{align*}
\text{true} &\equiv \lambda x.\lambda y.x\\
\text{false} &\equiv \lambda x.\lambda y.y\\
\text{if a then b else c} &\equiv a\ b\ c
\end{align*}
$$

Convert the following sentences to their equivalent lambda calc encodings:

13. `if true then false else true`
14. `if false then if false then false else true else false`

Next, reduce the lambda calc expressions to their simplest form. Verify that the resulting expression is equivalent to the english sentence when evaluated.

## Additional Readings & Resources

- [Spring 2021 - Lambda Calculus Basics](https://www.cs.umd.edu/class/spring2021/cmsc330/lectures/24-lambda-calc-1.pdf)
- [Fall 2022 - Discussion 10 (Lambda Calculus)](https://github.com/umd-cmsc330/fall2022/tree/main/discussions/discussion10#lambda-calculus)
- [Types and Programming Languages (Pierce 2002)](https://www.cs.sjtu.edu.cn/~kzhu/cs383/Pierce_Types_Programming_Languages.pdf)
  - See Chapter 5: _The Untyped Lambda-Calculus_
- [nmittu.github.io - Beta Reduction Practice](https://nmittu.github.io/330-problem-generator/beta_reduction.html)
