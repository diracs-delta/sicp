(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
  
(define (adjoin-set x set) (cons x set))

(define (union-set s1 s2) (append s1 s2))

(define (intersection-set s1 s2)
  (cond
    ((null? s2) s1)
    ((null? s1) s2)
    ((element-of-set? (car s2) s1) (intersection-set s1 (cdr s2)))
    (else (intersection-set (cons (car s2) s1) (cdr s2)))
  )
)

; the above implementation is faster for adjoin/union but slower for element-of
; and intersection. it is preferable to use the above implementation when the
; number of element-of and intersection operations is relatively small relative
; to the number of adjoin and union operations.
