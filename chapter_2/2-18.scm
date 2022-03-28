(define (reverse l)
  ; reverses with an accumulated reversed list a
  (define (reverse-accum l a)
    (if (null? l)
      a
      (reverse-accum (cdr l) (cons (car l) a)))
  )
  (reverse-accum l (list))
)

(reverse (list))
(reverse (list 1 2 3 4 5))