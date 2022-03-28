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

(define (enumerate-interval a b)
  (if (> a b)
    nil
    (append (list a) (enumerate-interval (+ a 1) b))
  )
)

(define (flatmap proc seq) (accumulate append nil (map proc seq)))

; maps each element in seq to another list and then flattens the list of lists
;
; Loop invariant: at each iteration i, the set of all pairs (j, i) where j < i
; is appended to the accumulated list.
;
; Thus, when the loop terminates at i = n, we have the set of all pairs 
(define (unique-pairs n)
  (flatmap
    (lambda (i)
      (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1)))
    )
    (enumerate-interval 1 n)
  )
)

(unique-pairs 5)
