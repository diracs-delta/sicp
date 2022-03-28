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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; enumerates all integer triples (i, j, k) such that 0 < i, j, k <= n.
(define (enumerate-triples n)
  (flatmap
    (lambda (i) (flatmap
      (lambda (j) (map
        (lambda (k) (list i j k))
        (enumerate-interval 1 n)
      ))
      (enumerate-interval 1 n)
    ))
    (enumerate-interval 1 n)
  )
)

; tests whether a given triple (i, j, k) satisfies the property i + j + k = s.
(define (triple-sum-equal? triple s)
  (let ((x (car triple))
        (y (cadr triple))
        (z (caddr triple)))
    (= (+ x y z) s)
  )
)

; can't think of a better name for this function
; finds all triples (i, j, k) where 0 < i, j, k <= n and i + j + k = s
(define (solve-241 n s)
  (filter (lambda (triple) (triple-sum-equal? triple s)) (enumerate-triples 5))
)

(solve-241 5 10)
