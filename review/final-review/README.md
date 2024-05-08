# Final Review Session

## RUST

### [Cliff’s Notes](https://bakalian.cs.umd.edu/assets/notes/rust.pdf) & [Rust Book](https://doc.rust-lang.org/book/title-page.html)

**Basics:**

- Rust aims to be a “safe” language, which it does by being “over-protective”
- Rust has statements, codeblocks, and expressions:
    - Codeblocks are run independently from the rest of the function, with their own scope:
    
    ```rust
    let x = 3;
    { //start of codeblock
    	1 + 2; //statement
    	3 + 5 //expression
    } //end of codeblock
    ```
    
    - Statements are evaluated, and end with semi-colons. Often, these are function calls or let statements.
    - Expressions *do not* have a semi-colon and are returned.
- Closures are like anonymous expressions!

```rust
let f = |x| x + 3;
// f(5) -> 8
```

**Ownership**:

Rust’s Ownership rules:

- Every value has an owner
- There can only be one owner of a value at a time
- When the owner goes out of scope, the value will be dropped (freed from memory)
- Examples:
    
    ```rust
    let s = String::from("Hello"); // s is the owner of Hello
    
    let x = s; // x has taken ownership, s is no longer valid
    ```
    
    ```rust
    
    let a = String::from("cmsc330"); // a is owner
    { 
    	let b = a; // b is owner
    	{ 
    		let c = b; // c is owner
    	}
    }
    // no owner, because c is out of scope
    ```
    

**Borrowing:**

When you don’t want to transfer ownership over to a function, you should let the function borrow the value. This is done by sending in a reference to the value → &x

Rules of Borrowing:

- Every reference must be valid
- One of the following (NOT both) must be true:
    - you can have any number of *immutable* references
    - you can have *one* mutable reference
- Examples
    
    ```rust
    let x = String::from("Hello");
    {
    	let y = &x; // temporarily borrows (immutable reference)
    	println!("can use {} and {}", x, y);
    }
    // y now out of scope
    println!("can use {}", x);
    ```
    
    ```rust
    fn main() {
    	let x = String::from("Hello");
    	let y = get_len(&x); //function borrows x's value
    	println!("{} has length {}", x, y); // then returns value to x
    }
    
    fn get_len(a: &String) -> usize {
    	a.len()
    }
    ```
    

**Lifetimes:**

The goal of lifetimes is to prevent *dangling pointers*, an issue we saw often in C. To prevent this, we say that a value lives until it either 

1) goes out of scope (function or codeblock it was defined in ends) OR

2) its final use

- We show lifetimes using the ’a, ’b format (don’t confuse with OCaml generic types!)
    - Examples:
        
        ```rust
        fn main() {
            let r;                // ---------+-- 'a
                                  //          |
            {                     //          |
                let x = 5;        // -+-- 'b  |
                r = &x;           //  |       |
            }                     // -+       |
                                  //          |
            println!("r: {}", r); //          |
        }                         // ---------+
        
        ```
        
        ```rust
        fn main() {
            let x = 5;            // ----------+-- 'b
                                  //           |
            let r = &x;           // --+-- 'a  |
                                  //   |       |
            println!("r: {}", r); //   |       |
                                  // --+       |
        }                         // ----------+
        ```
        
- If we want a value to live longer, we can use *lifetime annotations*
    
    ```rust
    fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
        if x.len() > y.len() {
            x
        } else {
            y
        }
    }
    ```
    

**Smart Pointers:**

Act like Pointers in C, but with extra meta-data. Usually, they own the data they point to (distinct from borrowing)

Implement the `Drop` and `Deref` traits

- **Boxes**
    - `Box<T>`
    - Allow storing of data on the heap rather than the stack. In the stack, a reference is held to that data. (Like wrappers in Java!)
    
    ```rust
    fn main() {
        let b = Box::new(5); // creating a box around value 5
        println!("b = {}", b);
    }
    ```
    
    The importance of this, as well as the most common use case, is that it allows us to safely implement a *recursive type*
    
    - At compile time, Rust needs to know the size of all types. Because of the nature of recursion, this is not guaranteed. However, we *do* know the size of a Box type, allowing us to surround our data with a Box and recurse.
    - Example:
        - Consider a linked list data type called Cons, which can store data in a list like so:
        
        ```rust
        let list = Cons(1, Cons(2, Cons(3, Nil)));
        // a list of [1, 2, 3]
        ```
        
        To write this, we may think we should create an enum that looks like this: 
        
        ```rust
        enum List {              (1)
            Cons(i32, List),     (2)
            Nil,                 (3)
        }                        (4)
        ```
        
        But this will error! Because this is a *recursive* data type, the size of the List on line 2 is unknown. To fix this, we wrap our data type in a Box, and define any instances of this type with that in mind.
        
        ```rust
        enum List {
            Cons(i32, Box<List>),
            Nil,
        }
        
        use crate::List::{Cons, Nil};
        
        fn main() {
            let list = Cons(1, Box::new(Cons(2, Box::new(Cons(3, Box::new(Nil))))));
        }
        ```
        
- **Reference Counters**
    - `Rc<T>`
    - Allows a single value to have multiple owners. Only when the last owner’s lifetime ends is the value dropped.
    - Examples:
        - Using the same linked list structure as the Boxes example:
        
        ```rust
        enum List {
            Cons(i32, Rc<List>),
            Nil,
        }
        
        use crate::List::{Cons, Nil};
        use std::rc::Rc;
        
        fn main() {
            let a = Rc::new(Cons(5, Rc::new(Cons(10, Rc::new(Nil)))));
            let b = Cons(3, Rc::clone(&a));
            let c = Cons(4, Rc::clone(&a));
        }
        ```
        
        - `Rc::clone` does not perform a deep copy like a.clone() might. It increments the reference counter to that piece of data.
        - We can call `Rc::strong_count(&a)` to see this reference counter!

## Lambda Calculus

## Operational Semantics & Type Checking

### OpSem
- Goal of operational semantics
    - give meaning to the language
        - specifically how we are allowed to use it / how it operates
        - symbols are arbitrary: could define ? as adding numbers together, ex 4?3 -> 7
    - prove the correctness of a program
        - does the program run how we expect it to run? in other words, does it follow the rules given to us?

- Target language: language we're talking about - used in conclusion on bottom part of rule
    - structure could be defined using a CFG like in project 4
- Meta language: language we're using to describe the target language - used in premises on top part of rule
    - working with its types and semantics when evaluating

- Axiom: a conclusion or rule that is known to be true - has line on top
    - a number always evaluates to itself, "false" is "false"
- For an expression, build a proof from the bottom up
    - each subexpression eventually should evaluate to one defined by an axiom
    - can nest rules to derive new expressions
- mappings from variables to values stored in environment, lookup to get them
- Examples!

### Type Checking
- Type Systems
    - A series of rules that ascribe types to expressions
    - A mechanism for distinguishing good programs from bad
        - good programs are well-typed
        - Examples
            - 0 + 1 -> well typed
            - false 0 -> ill-typed: can’t apply a Boolean
            - 1 + (if true then 0 else false) // ill-typed: can’t add boolean to integer
    - The same rules we used in operational semantics can be used to specify a program’s static semantics
        - `G ⊢ e : t`  → e has type t in context G
        - `G(x)` → look up x's type in G
        - `G,x:t`→ extend G so that x maps to t
- Rules
    - `G ⊢ true : bool` & `G ⊢ false : bool` & `G ⊢ n : Int`
    - `G ⊢e1: t1, G ⊢e2: t2, optype(op) = (t1,t2,t3)`
          ---
              `G ⊢ e1 op e2: t3`
    - `G ⊢ x : G(x)`
- Some theory stuff
    - A type-safe language is one in which for every program, **well typed** implies **well defined**
    - Type safety is a soundness property
        - That a term type checks implies its execution will be well-defined
    - Static-type systems are rarely complete
        - That a term is well-defined does not imply that it will type-check
            - Ex: if true then 0 else 4+"hi”
    - Dynamic type systems are often complete
        - All expressions are well-defined and (statically) type-check
            - Ex: 31 • 4+"hi" well-defined: it gives a run-time exception
    - No type system can do all of the following
        - always terminate
        - be sound
        - be complete
- Examples!

## FSM, NFA-DFA
- Some theory stuff!
    - E-closure and move are not the same. An E-closure call can never return an empty set but the same cannot be said about the move function.
      ![e-closure move example](https://github.com/umd-cmsc330/spring24-ta/assets/100861119/1c581110-3273-4456-aed2-c57591b7f7a0)
    - FSM's are of 2 types: NFA, DFA.
      - Both of them can be used to represent a regular language.
      - What differentiates them is the fact that NFA's have epsilon - transitions and ambigiuity involved when moving from one state to another but the same cannot be said for DFA's.
      - You can convert a NFA to DFA always. You can use something known as the table method to help solve such problems but are more than welcome to follow your own method!. The structure of the table looks something like this typically :
        ![NFATODFA table](https://github.com/umd-cmsc330/spring24-ta/assets/100861119/01838d13-3a02-4225-ba52-c21313e08e1b)
    - Since NFA and DFA both can represent a regular language it is possible for us to use a regular expression to build one of these 2 systems. Some common structure representations that may help you solve problems such as "Convert Regex to NFA" or "What is the regex for the corresponding NFA system" are:
       ![character_transitoin](https://github.com/umd-cmsc330/spring24-ta/assets/100861119/8c46cf68-2f8d-4ea8-b328-d304a922d56d)
       ![concat](https://github.com/umd-cmsc330/spring24-ta/assets/100861119/8f35e0e7-3ec3-432d-b429-d3f0c5fab4c4)
       ![Branching](https://github.com/umd-cmsc330/spring24-ta/assets/100861119/0e81b233-6575-448e-a05a-94369c5ef767)
       ![kleene closure](https://github.com/umd-cmsc330/spring24-ta/assets/100861119/2c1266b2-795b-40c2-b896-43730eb432d1)
- Problems!
    -Here's a solution doc link to the problems we will be discussing during the review session! **Please don't make any edits to the document since they will be reflected in the document for everyone else** --> https://share.goodnotes.com/s/ts1aGyPcLJkBMajqEdTBqy
## PL Concepts & OCaml Typing
