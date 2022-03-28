(define (for-each proc l)
  (define (next)
    (proc (car l))
    (for-each proc (cdr l))
  )
  (if (null? l) #t (next))
)

; handles nil input
(for-each (lambda (x) (newline) (display x)) (list))
; oh, and it actually works. i pinky promise.
(for-each (lambda (x) (newline) (display x)) (list 57 321 88))