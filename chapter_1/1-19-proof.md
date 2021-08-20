# Exercise 1-19 Proof

## Problem

Let $T_{pq}^i(a, b)$ be a transformation $\R^2 \rightarrow \R^2$ defined by the
recursive relation

$$
T_{pq}^i(a, b) = T_{pq}(T_{pq}^{(i-1)}(a, b)),
$$

where

$$
T_{pq}^1(a, b) \equiv T_{pq}(a, b) \equiv (bq + aq + ap, bp + aq).
$$

It follows that by definition, for any integer $i$,

$$
T_{pq}^{2i}(a, b) = T_{pq}^{i}(T_{pq}^{i}(a, b))
$$

Our goal is to determine unknown functions $p' = p(p, q), q' = q(p, q)$ such
that upon the substitution $p = p'(p, q), q = q'(p, q)$,

$$
T_{pq}^{2i}(a, b) = T_{p'(p, q) q'(p, q)}^{i}(a, b).
$$

Finding the above would allow us to build an iterative algorithm that computes
$T_{pq}^n(a, b)$ in $\Theta(\lg n)$ time.

## Solution

The first step is to observe the following relation via substitution:

$$
T_{pq}^{2}(a, b) =
	(bp + aq)q + (bq +aq + ap)q + (bq + aq +ap)p,
	(bp + aq)p + (bq + aq + ap)q
$$

After expanding and factoring out $a, b$ for each term, it can be shown that

$$
T_{pq}^{2}(a, b) = T_{p'(p, q), q'(p, q)}(a, b),
$$

where

$$
p'(p, q) = p^2 + q^2,
\\
q'(p, q) = q^2 + 2pq.
$$

Given this, we can outline a formal proof by induction.

### Proposition

For any $i$, the relation

$$
T_{pq}^{2i}(a, b) = T_{p'(p, q), q'(p, q)}^i(a, b),
$$

holds for all positive integers $i$, where

$$
p'(p, q) = p^2 + q^2,
\\
q'(p, q) = q^2 + 2pq.
$$

### Proof

#### Base case $i = 1$

(already shown above)

#### Inductive step

Now suppose the inductive hypothesis holds for any arbitrary $i$. Given this, we
wish to demonstrate the hypothesis necessarily holds for $i+1$.

$$
T^{2(i+1)}_{pq}(a,b) = T^2_{pq}(T^{2i}_{pq}(a, b))
	= T_{p'(p,q)q'(p,q)}(T^i_{p'(p,q)q'(p,q)}(a,b))
	= T^{(i+1)}_{p'(p,q)q'(p,q)}(a,b)
$$

Thus, given the inductive hypothesis holds for any $i$, it also holds any $i+1$,
proving the inductive step. Since the base case and the inductive step have been
proven, it follows by mathematical induction that the proposition holds for any
positive integer $i$. $\blacksquare$
