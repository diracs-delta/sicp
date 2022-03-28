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

(define (reverse-right sequence)
  (fold-right (lambda (x y)
    (append y (list x))
  ) nil sequence)
)

(define (reverse-left sequence)
  (fold-left (lambda (x y)
    (append (list y) x)
  ) nil sequence)
)

(reverse-right (list 1 2 3 4 5))
(reverse-left (list 1 2 3 4 5))
