(define nil (list))

(define (map proc items)
  (if (null? items)
    nil
    (cons (proc (car items)) (map proc (cdr items)))
  )
)

(define (square-list items)
  (if (null? items)
    nil
    (cons (expt (car items) 2) (square-list (cdr items)))
  )
)

(square-list (list 1 2 3 4 5))

(define (square-list items)
  (map (lambda (x) (expt x 2)) items)
)

(square-list (list 1 2 3 4 5))