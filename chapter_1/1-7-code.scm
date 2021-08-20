(define (average x y) (/ (+ x y) 2))

(define (improve guess x) (average guess (/ x guess)))

(define (good-enough-abs? guess x) (< (abs (- (square guess) x)) 0.001))
(define (good-enough-rel? previousGuess guess) (< (/ (abs (- previousGuess guess)) guess) 0.001))

(define (sqrt-iter-abs-diff guess x) (
	if (good-enough-abs? guess x)
		guess
		(sqrt-iter-abs-diff (improve guess x) x)
))


(define (sqrt-iter-rel-diff previousGuess guess x) (
	if (good-enough-rel? previousGuess guess)
		guess
		(sqrt-iter-rel-diff guess (improve guess x) x)
))


(define (sqrt-abs-diff x) (sqrt-iter-abs-diff 1.0 x))
(define (sqrt-rel-diff x) (sqrt-iter-rel-diff 0 1.0 x))

; Expected: 1e-5
(sqrt-rel-diff 0.0000000001)
; (sqrt-abs-diff 0.0000000001)

; Expected: 3162277.66
(sqrt-rel-diff 10000000000000)
; (sqrt-abs-diff 10000000000000)
