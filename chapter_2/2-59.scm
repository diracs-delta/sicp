(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (union-set s1 s2)
  (cond
    ((null? s1) s2)
    ((null? s2) s1)
    ((element-of-set? (car s2) s1) (union-set s1 (cdr s2)))
    (else (cons (car s2) (union-set s1 (cdr s2))))
  )
)

(union-set '(1 2 3) '())
(union-set '() '(1 2 3))
(union-set '(1 2 3) '(2 4 6))