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

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs))
    )
  )
)

(define (dot-product v w)
  (accumulate + 0 (map * v w))
)

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product v row)) m)
)

(define (transpose mat)
  (accumulate-n cons nil mat)
)

(define (matrix-*-matrix m n)
  (let ((n-cols (transpose n)))
    (map (lambda (m-row) (map (lambda (n-col) (dot-product m-row n-col)) n-cols)) m)
  )
)

(define v1 (list 2 3 5))

(define m1 (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define m2 (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))

; Expected: (2 3 5)
(matrix-*-vector m1 v1)
; Expected: (21 53 83)
(matrix-*-vector m2 v1)

; Expected: ((1 0 0) (0 1 0) (0 0 1))
(transpose m1)
; Expected: ((1 4 7) (2 5 8) (3 6 9))
(transpose m2)

; Expected: ((1 2 3) (4 5 6) (7 8 9))
(matrix-*-matrix m1 m2)
(matrix-*-matrix m2 m1)

; Expected: ((30 36 42) (66 81 96) (102 126 150))
(matrix-*-matrix m2 m2)
