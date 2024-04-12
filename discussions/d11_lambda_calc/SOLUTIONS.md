# Solutions

**Make the parentheses explicit in the following expressions:**

1. `((a b) c)`

2. `(λa. (λb. (c b)))`

3. `(λa. ((a b) (λa. (a b))))`

**Identify the free variables in the following expressions:**

5. λa. a **b** a

6. **a** (λa. a) **a**

7. λa. (λb. a b) a **b**

**Apply alpha-conversions to the following:**

7. `λa. λx. x`

8. `(λx. x) a b`

9. `(λx. (λy. (λz. z) y) x)`

**Apply beta-reductions to the following:**

10. `(x b) b`

11. `b`

12. `(λa. a a) (λa. a a) → (λa. a a) (λa. a a) → (λa. a a) (λa. a a) → ... infinite recursion`

**Church encodings**

13. <>
    ```
    (λx. λy. x) (λx. λy. y) (λx. λy. x)
    (λy. (λx. λy. y)) (λx. λy. x)
    (λx. λy. y)
    false
    ```
14. <>
    ```
    (λx. λy. y) ((λx. λy. y) (λx. λy. y) (λx. λy. x)) (λx. λy. y)
    (λx. λy. y) ((λy. y) (λx. λy. x)) (λx. λy. y)
    (λx. λy. y) (λx. λy. x) (λx. λy. y)
    (λy. y)  (λx. λy. y)
    (λx. λy. y)
    false
    ```
