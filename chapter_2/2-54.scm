(define (equal? a b)
  (cond
    ((and (null? a) (null? b)) #t)
    ((or (null? a) (null? b)) #f)
    (else
      (and (eq? (car a) (car b)) (equal? (cdr a) (cdr b)))
    )
  )
)

; #t
(equal? '(a b c) '(a b c))
; #f
(equal? '() '(a b c))
; #t
(equal? '() '())
; #f
(equal? '(a b c) '((a) (b) (c)))