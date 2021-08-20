; Assumed to be constant-time operations
(define (double x) (* x 2))
(define (halve x) (/ x 2))

; Loop invariant: The return value of each recursive call is equal to the product a * b.
(define (recurs-mult a b)
	(cond
		((= b 1) a)
		((even? b) (recurs-mult (double a) (halve b)))
		(else (+ a (recurs-mult a (- b 1))))
	)
)

(recurs-mult 111111111 111111111)
