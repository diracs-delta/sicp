# Chapter 1: Building Abstractions with Procedures

- [Chapter 1: Building Abstractions with Procedures](#chapter-1-building-abstractions-with-procedures)
	- [1.1: The Elements of Programming](#11-the-elements-of-programming)
		- [1.1.1: Expressions](#111-expressions)
		- [1.1.2: Naming and the Environment](#112-naming-and-the-environment)
		- [1.1.3 Evaluating Combinations](#113-evaluating-combinations)
		- [1.1.4: Compound Procedures](#114-compound-procedures)
		- [1.1.5 The Substitution Model for Procedure Application](#115-the-substitution-model-for-procedure-application)
		- [1.1.6 Conditional Expressions and Predicates](#116-conditional-expressions-and-predicates)
		- [1.1.7 Example: Square Roots by Newton's Method](#117-example-square-roots-by-newtons-method)
		- [1.1.8 Procedures as Black-Box Abstractions](#118-procedures-as-black-box-abstractions)
	- [1.2 Procedures and the Processes They Generate](#12-procedures-and-the-processes-they-generate)
	- [Glossary](#glossary)

## 1.1: The Elements of Programming

### 1.1.1: Expressions

An *expression* is any sequence of symbols that are well-formed and evaluable in
the context of the language. Evaluation of an expression returns an expression
termed the *result*. Do note that this is a very loose definition that may not
fit in the definition of an "expression" in other languages; here it simply
means any sequence of symbols that's valid and evaluable.

A *procedure* is an expression that accepts other subsequent expressions termed
*arguments*. These are typically called "functions" in other languages.

*Primitive expressions* are the simplest pre-defined expressions that exist
within a language. These can include *primitive procedures* such as `+` or `-`,
and can include numerals such as `486` (which represents the abstract idea of
the number "486" in base-10).

Every primitive expression in Scheme Lisp returns a result.

```scheme
=> 486

;Value: 486

=> +

;Value: #[arity-dispatched-procedure 12]
```

*Combinations* are non-primitive, compound expressions containing an *operator*
which refers to a procedure, and *operands* which refer to arguments of the
procedure. In Scheme Lisp, a combination is represented by parentheses and the
operator specified first (a convention termed *prefix notation*).

```scheme
=> (+ 1 2)

;Value: 3
```

Combinations can also accept other combinations as arguments.

```scheme
=> (+ 1 (+ 2 2))

;Value: 5
```

### 1.1.2: Naming and the Environment

In programming languages, a *name* identifies a *variable* which stores a
*value*. The relationship between a variable and a value is analogous to that of
a memory address and the data within a memory address. The association of a name
to a variable can be termed a *definition*.

In Scheme Lisp, a definition can be declared as follows:

```scheme
(define x 2)

;Value: x
```

The language interpreter stores the definitions in memory, which is called the
*environment*.

### 1.1.3 Evaluating Combinations

Evaluation of most combinations can be achieved through the following procedure,
termed the *general evaluation rule*:

1. Evaluate the subexpressions of the combination.

2. Apply the procedure that is the value of the leftmost subexpression (the
operator) to the arguments that are the values of the other subexpressions (the
operands).

3. For primitive expressions, we stipulate the following:

- the values of numerals are the numbers they name,

- the values of built-in operators are the machine instruction sequences that
carry out the corresponding operations,

- the values of other names are the objects associated with those names in the
environment

Note this rule is inherently recursive, as it necessarily invokes itself on the
arguments, which may also be combinations.

However, this rule does not cover all expressions, as certain expressions are exempt from this rule. For example, the definition expression

```scheme
(define x 2)
```

does not apply a "define" procedure to both `x` and `2`; it simply exists to
initialize the new definition `x = 2` in memory. Thus, this does not following
step (2) of the above rule.

Expressions that do not follow the general evaluation rule are termed *special
forms*. We will encounter more in the subsequent sections.

### 1.1.4: Compound Procedures

*Procedure definitions* are a more powerful abstraction that allow us to define
*compound procedures* (contrasted with primitive procedures). In Scheme Lisp,
this is accomplished in the following expression syntax:

```
(define (<name> <formal parameters>) <body>)
```

Example:

```scheme
(define (square x) (* x x))
(square 3)

;=> Value: 9
```

where `name` is the symbol associated with the procedure, `formal parameters`
are the names used within the `body` that refer to the arguments of the
procedure, and `body` is an expression or sequence of expressions that will
yield the value upon substitution of formal parameters by provided arguments.

Similar to combinations, compound definitions may nest one another.

```scheme
(define (cube x) (* x (square x)))
(cube 3)

;=> Value: 27
```

### 1.1.5 The Substitution Model for Procedure Application

This brings us to an additional step in the *general evaluation rule* discussed
in 1.1.3, which determines how to evaluate expressions containing compound
procedures.

4. To apply a compound procedure to arguments, evaluate the body of the
procedure with each formal parameter replaced by the corresponding argument.

However, note that even with both steps 3 and 4, the general evaluation rule is
still open-ended. What do we mean by "replaced by the corresponding argument"?
For example, given the definition of `square` in the preceding subsection, do we
evaluate

```scheme
(square (square 2))
```

like this:

```scheme
(square (* 2 2))
(square 4)
(* 4 4)

;=> Value: 16
```

or like this?

```scheme
(* (square 2) (square 2))
(* (* 2 2) (* 2 2))
(* 4 (* 2 2))
(* 4 4)

;=> Value: 16
```

In this first method, we evaluate combinations containing primitive procedures
first, and then substitute the result into the compound procedure body. In the
second method, we directly substitute the combinations themselves into the
compound procedure body. For any compound procedure, there are different methods
of applying a procedure to its arguments.

These differing methods of compound procedure application are called
*substitution models*. Specifically, the two we have described are,
respectively:

- *Applicative-order substitution* -- First evaluate each argument using the
general evaluation rule, and then substitute the respective results into the
body of the compound procedure.

- *Normal-order* substitution -- First substitute each argument into the body of
the compound procedure, and then evaluate using the general evaluation rule.

Scheme Lisp uses applicative-order substitution, and for good reason. It avoids
duplicate evaluation of a procedure's arguments. Observe in the above example
that the primitive combination `(+ 2 2)` is evaluated twice using normal-order
substitution, but only once using applicative-order substitution.

Just to further emphasize this point: *the order of substitution in a procedure
can determine the runtime efficiency of a procedure*. This is amazing! Without
changing anything about a procedure, we can optimize its performance just by
changing the order in which we evaluate it.

As we will see later in section 1.2, the usage of applicative-order substitution
has a profound impact on the design of algorithms in Scheme Lisp.

### 1.1.6 Conditional Expressions and Predicates

Scheme Lisp has conditional special forms built-in.

```scheme
(cond
	(<predicate> <consequent>)
	(<predicate> <consequent>)
	...
	(else <alternative>)
)
```

`cond` is a special form that accepts multiple *clauses* as arguments. Each
clause contains a *predicate expression* and a *consequent expression*. To
evalute `cond` expressions, the interpreter runs through each clause, evaluating
the predicate and returning the result of evaluating the consequent if the
predicate returns a truish value. If the final clause contains `else` (or any
truish predicate) and none of the other clauses return a truish value, then the
*alternative expression* is evaluated and returned.

```scheme
(if <predicate> <consequent> <alternative>)
```

`if` is a similar special form that behaves the exact same as `cond`, except
that it is used when there are exclusively two cases.

Compound predicate expressions can be constructed using *logical composition
operations*. They include `and`, `or`, and `not`. `and` and `or` are special
forms. The operations do exactly what you would expect; I'm not typing them out
because I have RSI.

### 1.1.7 Example: Square Roots by Newton's Method

A neat example illustrating a basic numerical algorithm that computes square
roots.

### 1.1.8 Procedures as Black-Box Abstractions

Procedures are best thought of as *black-box abstractions*; the user calling a
procedure should not have to know how the procedure is implemented to use it.

This requires the formal parameters of each procedure to be *local* to the body
of the procedure; otherwise, formal parameters sharing the same name would
conflict with one another, conflicting with our representation of procedures as
black-box abstractions.

We state that the formal parameters are *bound variables*, and that a procedure
definition *binds* its formal parameters. The *scope* of an expression is the
set of expressions for which a binding defines a name. *Free variables* are
variables that are available everywhere within a given scope.

In a procedure definition, the scope of the formal parameters is restricted to
the body of the procedure.

For example, in the procedure definition

```scheme
(define (good-enough? guess x) (...))
```

In the body of `good-enough?`, `guess` and `x` are bound, while `abs`, `=`, `>`,
etc. are free. If the the formal parameter `x` were renamed to `abs`, that would
cause a bug if `abs` was used in the body of `good-enough?` as the variable
`abs` would have been *captured*, i.e. having changed from free to bound.

Definitions can be nested such that they are defined within the body of other
enclosing definitions, and are within the scope of each formal parameter of each
enclosing definition. For example:

```scheme
(define (sqrt x) (
	; x is a free variable within the definition of sqrt, no need to
	; explicitly pass x as a formal parameter to internal definitions.
	(define (sqrt-iter guess) (...))
	(sqrt-iter 1.0)
))
```

This concept is called *block structure*, and was introduced in Algol 60.

There are two main ways of resolving a name within the body of a procedure.

- *Lexical scoping* (also termed *static scoping*): a procedure body inherits
the lexical/static context of its definition.

- *Dynamic scoping*: a procedure body inherits the dynamic context of where the
procedure is evaluated.

These two rules are part of a language's *scope rules*, which determine how to
resolve variable names and determine variable scopes. To illustrate the
difference between these two rules, consider the following example:

```scheme
(define x 0)
(define g x)

; Does (f) return 1 or 0?
(define f (
	(define x 1)
	(g)
))
```

With lexical scoping, `(f)` would return `0`, as `g` resolves `x` in the context
of its definition, where `x = 0`. With dynamic scoping, name resolution occurs
at runtime, and `x` resolves to `1` as `g` inherits the context of where it is
called, the body of `f`, in which `x` is defined to be `1` on the preceding
line.

As it turns out, Scheme Lisp along with most other modern languages use lexical
scoping. An example of a language utilizing dynamic scoping is `bash`.

## 1.2 Procedures and the Processes They Generate

*Procedures* provide a pattern for the local evolution of a *process*. Each step
*of a process is defined by a given procedure.

There are two major types of processes that are best illustrated by example.
Consider the process generated by the following procedure:

```scheme
(define (factorial n) (
	(if (= n 1) 1 (* n (factorial (- n 1))))
))
```

Evaluation of the expression `(factorial 6)` leads to the following local
evolution:

```scheme
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
; Value: 720
```

This is a *recursive process*, characterized by a chain of deferred operations.

In contrast, consider the process generated by the following procedure:

```scheme
(define (factorial n) (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
	(if (> counter max-count)
		product
		(fact-iter (* counter product) (+ counter 1) max-count)
	)
)
```

Evaluation of the expression `(factorial 6)` with the above procedure leads to
the following local evolution:

```scheme
(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
; Value: 720
```

This is an *iterative process*, characterized by the usage of *state variables*
passed between evaluations of each step as parameters.

It's worth noting that in languages with applicative-order substitution,
recursive processes can be identified easily with the following observation:

> If a recursive procedure defines itself as an argument to another procedure,
then it must be a recursive process, as evaluation of the enclosing expression
must be deferred.

In the first example involving the recursive process, the `factorial` procedure
defines itself as an argument to the `*` primitive procedure. This necessarily
implies a recursive process since we cannot evaluate anything else until we
evaluate `(factorial (- n 1))`, and so on.

Furthermore, note that both processes rely on *recursive procedures*. A
*recursive procedure* is simply a procedure that calls itself, and implies
nothing about the character of the process that it generates.

The rest is mostly basics of complexity analysis and examples of iterative and
recursive processes. Really, this section is best left to a whole different
dedicated textbook on algorithms, like the infamous CLRS (another book I may do
a notes/exercises series on eventually).

## Glossary

This glossary is incomplete; it only contains the words that are the most
important in this book, and give me the most trouble.

- *Combinations* -- A non-primitive, compound expression containing an
*operator* which refers to a procedure, and *operands* which refer to arguments
of the procedure. Combinations are a subset of expressions.

- *Expression* -- Any sequence of symbols that are well-formed and evaluable in
the context of a language.

- *General evaluation rule* -- The general rule applied to evaluate expressions,
excluding special forms.  See section 1.1.3.

- *Numeral* -- An expression that represents a number in base-10. Example:
`486`.

- *Number* -- The abstract mathematical object represented by a numeral.
Example: "the integer following 485 and preceding 487".

- *Primitive expression* -- Any pre-defined expression in the context of a
language. *Primitive expressions* are a subset of *expressions*.

	- Examples: `4`, `+`.

<!-- - *Primitive combination* -- (personal shorthand; not in book) A combination
whose operator is a primitive procedure and whose operands are primitive
expressions. More succintly, a primitive combination is a combination consisting
purely of primitive expressions.

	- A primitive combination is NOT a primitive expression! It *consists*
	of primitive expressions.

	- Examples: `(+ 2 2)`, `(* 3 3)`
 -->

- *Primitive procedure* -- A *primitive expression* that is also a procedure.
*Primitive procedures* are the intersection between *primitive expressions* and
*procedures*, and are a subset of *expressions*.

	- Example: `+`.

- *Procedure* -- An expression that accepts other subsequent expressions termed
*arguments*. Procedures are a subset of expressions. Procedures are either
*primitive procedures* or *compound procedures*.

- *Special form* -- An expression that is exempt from the *general evaluation
rule*. Special forms are a subset of combinations, and, by extension, a subset
of expressions.

- *Substitution model* -- A model that determines how to evaluate a compound
procedure with non-primitive expressions passed as arguments.

	- Substitution model determines how to evaluate:

		```scheme
		(square (+ 2 2))
		```

		but not

		```scheme
		(square 4)
		```



