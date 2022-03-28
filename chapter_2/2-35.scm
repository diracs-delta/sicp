(define nil (list))

; accumulate works backwards with the given sequence. the last element in the
; sequence has the operator applied first.
;
; op accepts two arguments:
; 1. element of the list on this iteration (L_i)
; 2. the accumulated list of results thus far (op(L[i+1]), ..., op(L[n]))
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))
  )
)

; yeah i know this isn't the pre-defined way of doing it, but this works.
(define (count-leaves t)
  (accumulate
    (lambda (leaf accum)
      (+ accum (cond ((null? leaf) 0)
                     ((pair? leaf) (count-leaves leaf))
                     (else 1)
               )
      )
    )
    0
    t
  )
)

(define t1 (list (list 1 2) (list 3 4) (list 5 (list 6 (list 7 (list 8))))))
(count-leaves nil) ; 0
(count-leaves t1)  ; 8
