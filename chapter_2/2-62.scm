(define (union-set s1 s2)
  (cond
    ((null? s1) s2)
    ((null? s2) s1)
    (else 
      (let ((x1 (car s1)) (x2 (car s2)) (r1 (cdr s1)) (r2 (cdr s2))) 
        (cond
          ((< x1 x2) (cons x1 (union-set r1 s2)))
          ((> x1 x2) (cons x2 (union-set s1 r2)))
          ; else x1 = x2
          (else (cons x1 (union-set r1 r2)))
        )
      )
    )
  )
)

(union-set '(1 2 3) '(4 5 6))
(union-set '(1 2 3) '(1 2 3))
(union-set '() '(1 2 3))
(union-set '(1 2 3 4 5 6) '(4 6 8))