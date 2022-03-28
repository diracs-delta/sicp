(define nil (list))

; accumulate works backwards with the given sequence. the last element in the
; sequence has the operator applied first.
;
; op accepts two arguments:
; 1. element of the list on this iteration (L_i)
; 2. the accumulated list of results thus far
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))
  )
)

(define fold-right accumulate)

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest)) (cdr rest))
    )
  )
  (iter initial sequence)
)

(fold-right / 1 (list 1 2 3)) ; 3/2
(fold-left / 1 (list 1 2 3)) ; 1/6
(fold-right list nil (list 1 2 3)) ; (1 (2 (3 nil)))
(fold-left list nil (list 1 2 3))  ; (((nil 1) 2) 3)

; op must be *commutative*, i.e. (op a b) = (ob b a) for any a, b.
