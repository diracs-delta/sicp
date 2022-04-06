(define (make-accumulator value)
  (lambda (diff)
    (set! value (+ value diff))
    value
  )
)

(define A (make-accumulator 5))
(A 10)
(A 15)