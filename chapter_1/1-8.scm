(define (good-enough-rel? previousGuess guess) (< (/ (abs (- previousGuess guess)) guess) 0.001))

(define (square x) (* x x))
(define (iterate guess x) (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-root-iter previousGuess guess x) (
	if (good-enough-rel? previousGuess guess)
		guess
		(cube-root-iter guess (iterate guess x) x)
))

(define (cube-root x) (cube-root-iter 0 1.0 x))

(cube-root 1234)