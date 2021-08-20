(define (f-recursive n) (if (< n 3)
	3
	(+ (f-recursive (- n 1)) (* 2 (f-recursive (- n 2))) (* 3 (f-recursive (- n 3))))
))

; Invariant: at each iteration k, a = f(k + 2), b = f(k + 1), c = f(k)
(define (f-iterative n)
	(define (f-iterative-with-counter a b c k) (if (<= n (+ k 2))
		a
		(f-iterative-with-counter (+ a (* 2 b) (* 3 c)) a b (+ k 1))
	))
	(f-iterative-with-counter 3 3 3 0)
)

(f-recursive 0)
(f-recursive 1)
(f-recursive 2)
(f-recursive 3)
(f-recursive 10)
(f-recursive 20)

(f-iterative 0)
(f-iterative 1)
(f-iterative 2)
(f-iterative 3)
(f-iterative 10)
(f-iterative 20)
