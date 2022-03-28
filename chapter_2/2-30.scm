(define nil '())

(define (square-tree-direct t)
  (cond ((null? t) nil)
        ((pair? t)
          (cons (square-tree-direct (car t)) (square-tree-direct (cdr t)))
        )
        ; t must be a non-null leaf 
        (else (square t))
  )
)

(define (square-tree-recurs t)
  (map (lambda (l) ; l for leaf
    (if (pair? l)
      (square-tree-recurs l)
      (square l)
    )
  ) t)
)

(define t1 (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(square-tree-direct t1)
(square-tree-recurs t1)
