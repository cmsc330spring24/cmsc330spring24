# Exam 1 Review Session
## PL Concepts and OCaml Basics (20 mins)
* Syntax: what a program looks like
* Semantics: what a program means (what it computes)
  * Same syntax could have different meanings for different languages
  * Formal semantics–mathematical definition, such as operational semantics
* Paradigm
  * Fundamental differences
    * Recursion vs Looping
    * Mutation vs Functional Update
    * Manual vs Automatic Memory Management
  * Scripting/Dynamic
    * Higher-layer abstractions
  * Imperative/Functional is on the next section
  * Implementation
    * Compilation vs Interpretation
      * Compiler: source program translated to machine code then executed (gcc, javac)
      * Interpreter: executes each instruction one step at a time
  * Functional vs Imperative
    * Functional
      * Higher level of abstraction
#### Imperative vs Functional
  * Imperative - procedural, where building blocks are procedures and statements
  * Functional
    * immutability
      * Variables are never re-defined
      * New variable is a function of old ones
    * Higher-order
      * Functions are passed as arguments and returned as results
    * OCaml
      * pattern matching, module system, type inference (compile-time type checking)
#### OCaml Specific
  * Ocaml is a compiled and bootstrapped language
  * Implicitly typed --> the compiler infers the type of your variables and values at compile time
  * Statically typed --> once the type of a variable is inferred, the variable must abide by the type throughout its scope (type encforcement)
  * Primitive built-in data types
     * int, float, char, string, bool, and unit
     * Composite data types include tuples, lists, option, and variants
  * Arithmetic operators in Ocaml are not overloaded --> you can use +, -, *, / on two ints but not on floats
  * tuples - heterogenous, can have different types, can vary in length
  * lists - honmogeneous, can only have same times, can vary in length
   * `::` vs `@` -> `element :: [list of the type of the element]` vs `['a] @ ['a]`
   * There are also no statements in OCaml, everything is an expression, all expressions have values (expressions get evaluated to values), and all values have types. Even functions are expressions and those have their own types!!
  * Records vs Variants
   * Records and variants are both user defined types
    * Records generally used when for description
    * Variants generally used for polymorphism
#### More PL Concepts
 * Currying - transformation of a function that takes in multiple arguments to functions that take less arguments -> `let f a b = a + b in let g = f 5 in g 5;;` evaluates to 10
 * Shadowing - a variable is declared within a certain scope, then it shadows the variable declared outside of the scope with the same name
 * Side effects - operations that "do more" than just return a result (printing, file input, exceptions)

## OCaml Typing and Higher Order Functions (30 mins)


## Regular Expressions (30 mins)
* A pattern that describes a set of strings
* Defines a regular language, which can be created from a finite state machine.
* Creating regular expressions
  * [a-z] -> all ASCII characters from a to z (basically all lowercase letters)
  * [A-Z] -> all uppercase letters
  * [0-9] -> every digit from 0 to 9
    * as we can see, [r1-r2] is a range specification
      * Can ```[a-Z]``` represent a lowercase or an uppercase letter?    
  * (a|b) -> a **or** b
  * (cs|ece) -> capture "cs" **or** "ece"
    * what if we did "[cs|ece]" ?
      
* Regex operators
  * \* -> zero or more repetitions of the preceding character or group
  * \+ -> one or more repetitions of the preceding character or group
  * ? -> zero or one repetitions of the preceding character or group
  * \. ->  any character
  * \{n\} -> exactly n repetitions of the preceding character or group
  * \{m, n\} -> at least m and at most n repetitions of the preceding character or group
  * \{n,\} -> at least n repetitions of the preceding character or group}
  * r1|r2 -> r1 or r2
     * You do not have to memorize these, they are on the cheatsheet!
* Some examples
  *  Write a regular expression that accepts id: XXX-XX-XXXX codename: <codename> where each X represents a number (can be different numbers) and <codename> is a string **beginning with an uppercase letter** that may have additional uppercase **and/or** lowercase letters after it.
   
     For example, the following strings should be accepted:    
       - id: 669-98-3600 codename: Watch
       - id: 123-45-6789 codename: McGregor 
     The following strings should be rejected:        
       - id: 123456789 codename: Wrong
       - id: 987-65-4321 codename: nope
  * Write a regex that describes a subset of valid UMD emails. Emails take the form of a user’s directory ID followed by the @ symbol, followed by one of the following domain names: cs.umd.edu, terpmail.umd.edu, or just umd.edu.
    
     Additional constraints: 
       - A user’s directory ID can be length 0 to length 8 consisting of only alphanumeric (both upper and lowercase) characters.
       - A user’s directory ID may not start with an uppercase letter.
       - A user's directory ID must end with a digit.
         
* Regular Expressions in OCaml      
  * You need to include the re library. (https://ocaml.org/p/re/1.10.4/doc/Re/index.html)
    ```
    #require "re" (* only in utop *)
    let comp_re = Re.compile (Re.Posix.re "I am ([0-9]+) years old") in 
    let matched = Re.exec comp_re "I am 23 years old" in 
    print_string ("Age: " ^ (Re.Group.get matched 1))
    ```
## Finite State Machines, NFA-DFA (40 mins)
### GENERAL IMPORTANT POINTS 
 1) **Every NFA is a DFA but not every DFA is a NFA**
    - NFA’s have epsilon transitions which are not present in a DFA
 2) **It is not always going to be the case that we have to consume some form of a symbol when moving from one state to another**
 3) **Move and e-closure on a state will not always return the same result**

### WHAT ARE FSM’S 
1) **Anything that has some logic associated with it and has memory available for the purpose of storage is a Finite State Machine.**
2) **We can make use of regular expressions to represent a 5 set tuple which forms a finite state machine.**
    - **Set of all possible states**
    - **A starting state —> There can be only 1 starting state**
    - **A set of final or accepting states —> Must always be present and can potentially be multiple in number**
    - **A set of transitions —> (starting_state, alphabet, ending_state)**
    - **Alphabets —> represents set of all symbols in the regex**
### HOW CAN WE CLASSIFY FSM’S
**All FSM’s can be described to be either deterministic or non deterministic**
 - **DFA ( Deterministic Finite Automata )**
 - **NFA ( Nondeterministic Finite Automata )**

### HOW CAN WE DIFFERENTIATE BETWEEN A NFA AND DFA###
 - **There’s no ambiguity involved when moving from one state to another.**
 - **NFA’s have epsilon transitions**

### NFA VS DFA
 - **Due to ambiguity in the number of output possibilities it is very expensive for us to check for string acceptance in NFA’s.**
 - **It is easier to convert a regular expression to NFA and since NFA’s are condensed in comparison to DFA’s we can say they are space efficient.**

### ε-closure
 - **Function that returns us a set of all the states that we can visit from our current state just using the ε-transition.**
    - **This means that we can only move from one state to another using ε-transitions and no other symbol**
    ![IMG_06454F32841E-1 (1)](./imgs/6e35a89b-852b-4e70-904a-59b62eaf8571.png)

### move
 - **Function that returns us a set of all possible states which we can reach from our current state using the specified symbol**
    - **The move call is done only once unlike e-closure!**
    ![IMG_97532BCB6B36-1 (1)](./imgs/d1624135-0d6f-4866-8a08-56e87db3670b.png)

### REGEX TO NFA
![IMG_52724B54B9A9-1 (1)](./imgs/39cc426f-3928-48bc-b4b2-30cff10a61cc.png)
![IMG_29553EDBEF31-1 (1)](./imgs/5ab52f09-e7c7-4309-bf3b-5d23746ab998.png)
![IMG_9950FF5DEE1E-1 (1)](./imgs/0467aad3-26b3-4100-9d4f-c0ba89918b55.png)

### NFA TO DFA
![IMG_CFF04C1D6E3E-1 (1)](./imgs/1104a5c3-82b9-431d-b923-d0d50381cef6.png)
![IMG_5BC43489E47A-1 (1)](./imgs/f91580a2-abd3-4aaf-8b74-a6c60967d719.png)
![IMG_01C46859F9B2-1 (1)](./imgs/9c7ec315-4760-4570-9fc3-07b3857ba65f.png)
![IMG_702CCE92D9D9-1 (1)](./imgs/57ca9161-5688-43dc-81f6-43f1f86b2a31.png)
![IMG_14E884807F97-1 (1)](./imgs/0eeab337-a277-4d24-b0fd-934eba44a589.png)

### PROBLEMS 
1)
<img width="635" alt="Screenshot 2024-03-03 at 11 12 25 PM" src="./imgs/98f735e7-c761-49f6-a8b0-abbf63e2a747.png">

2)
<img width="626" alt="Screenshot 2024-03-03 at 11 12 45 PM" src="./imgs/6985b60e-04b5-4d4d-9793-54a499c6afac.png">

3)
<img width="802" alt="Screenshot 2024-03-03 at 11 13 50 PM" src="./imgs/823732ae-3459-40d4-9a81-3420429dd814.png">

4) 
<img width="704" alt="Screenshot 2024-03-03 at 11 14 17 PM" src="./imgs/2e3f7421-5429-4907-82de-3d84fc1123a2.png">

5)
<img width="785" alt="Screenshot 2024-03-03 at 11 15 38 PM" src="./imgs/e5cb795f-60a1-42aa-86df-9d1a775bd39d.png">

6)
<img width="797" alt="Screenshot 2024-03-03 at 11 15 52 PM" src="./imgs/7ff12935-6b11-446b-8390-5cf0891e51f8.png">

7) Make this a regex to nfa problem
<img width="797" alt="Screenshot 2024-03-03 at 11 15 52 PM" src="./imgs/f334523d-e957-4f5d-ac01-232eed8eb2fe.png">

8) Make this a regex to nfa problem
<img width="657" alt="Screenshot 2024-03-03 at 11 16 15 PM" src="./imgs/ab03455b-0b7b-4735-b127-050ead3f632b.png">

9) 
<img width="687" alt="Screenshot 2024-03-03 at 11 17 09 PM" src="./imgs/d07a9ef3-e5eb-4d93-aca0-fa7084a41241.png">
