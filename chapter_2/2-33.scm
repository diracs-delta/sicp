(define nil '())

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

(define (map p sequence)
  (accumulate (lambda (el accum) (cons (p el) accum)) nil sequence)
)

(define (append seq1 seq2)
  (accumulate cons seq2 seq1)
)

(define (length sequence)
  (accumulate (lambda (_ accum) (+ accum 1)) 0 sequence)
)

(map square (list 1 2 3 4 5))
(append (list 1 2 3) (list 4 5 6))
(length (list 1 2 3 4 5))
