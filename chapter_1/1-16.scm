(define (square x) (* x x))
(define (halve x) (/ x 2))

; Loop invariant: accum * base^e is invariant between iterations
(define (iterExptWithAccum accum base e)
	(cond
		((= e 0) accum)
		((even? e) (iterExptWithAccum accum (square base) (halve e)))
		(else (iterExptWithAccum (* accum base) (square base) (halve (- e 1))))
	)
)

(define (fast-expt-iter x e) (iterExptWithAccum 1 x e))

(fast-expt-iter 2 100)