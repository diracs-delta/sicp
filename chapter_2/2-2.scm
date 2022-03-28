(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")")
)

(define (make-segment a b) (cons a b))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
(define (midpoint-segment s) (let
  (
    (x1 (x-point (start-segment s)))
    (y1 (y-point (start-segment s)))
    (x2 (x-point (end-segment s)))
    (y2 (y-point (end-segment s)))
  )
  (
    make-point (/ (+ x1 x2) 2) (/ (+ y1 y2) 2)
  )
))

(let ((s (make-segment (make-point -3 -3) (make-point 3 3))))
  (midpoint-segment s) ; should be 0, 0
)

(let ((s (make-segment (make-point 0 0) (make-point -1 -1))))
  (midpoint-segment s) ; should be -0.5, -0.5
)
