; (x, y) => (m) => m(x, y)
(define (cons x y) (lambda (m) (m x y)))

; (z) => z((p, q) => p)
(define (car z) (z (lambda (p q) p)))

; (z) => z((p, q) => q)
(define (cdr z) (z (lambda (p q) q)))