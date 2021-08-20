; Assumed to be constant-time operations
(define (double x) (* x 2))
(define (halve x) (/ x 2))

; Loop invariant: accum + (* a b) is invariant between iterations.
(define (fast-mult-with-accum accum a b) (cond
	((= b 0) accum)
	((even? b) (fast-mult-with-accum accum (double a) (halve b)))
	(else (fast-mult-with-accum (+ accum a) (double a) (halve (- b 1))))
))

(define (fast-mult a b) (fast-mult-with-accum 0 a b))

(fast-mult 111111111 111111111)
