(define (make-interval a b)
  (cons a b)
)

(define (upper-bound i)
  (max (car i) (cdr i))
)

(define (lower-bound i)
  (min (car i) (cdr i))
)

(define (sub-interval i1 i2) (let
  (
    (d1 (- (lower-bound i1) (lower-bound i2)))
    (d2 (- (upper-bound i1) (lower-bound i2)))
    (d3 (- (lower-bound i1) (upper-bound i2)))
    (d4 (- (upper-bound i1) (upper-bound i2)))
  )
  (make-interval (min d1 d2 d3 d4) (max d1 d2 d3 d4))
))
