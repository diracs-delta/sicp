(define (cons x y) (* (expt 2 x) (expt 3 y)))

(define (count-twos x)
  (define (count-twos-recurs x count)
    (if (= (remainder x 2) 0)
      (count-twos-recurs (/ x 2) (+ count 1))
      count
    )
  )
  (count-twos-recurs x 0)
)

(define (count-threes x)
  (define (count-threes-recurs x count)
    (if (= (remainder x 3) 0)
      (count-threes-recurs (/ x 3) (+ count 1))
      count
    )
  )
  (count-threes-recurs x 0)
)

(define (car p) (count-twos p))
(define (cdr p) (count-threes p))

(define p (cons 9 99))
(car p)
(cdr p)