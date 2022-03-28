(define nil (list))

(define (append-element l e) (append l (list e)))

(define (deep-reverse l)
  ; Strategy:
  ; check if (car l) is a pair
  ; => if so, simply append (car l) to the end, sort the rest.
  ; => otherwise, sort (car l) first before appending and sorting the rest.
  (cond ((null? l) l)
        ((pair? (car l))
          (append-element (deep-reverse (cdr l)) (deep-reverse (car l))))
        (else
          (append-element (deep-reverse (cdr l)) (car l)))
        ; alternative implementation (my first one)
        ; ((not (pair? l)) l)
        ; ((null? (cdr l)) (cons (deep-reverse (car l)) nil))
        ; (else (append-element (deep-reverse (cdr l)) (deep-reverse (car l))))
  )
)

; Input: ()
; Expected: ()
(deep-reverse (list))
; Input: (1)
; Expected: (1)
(deep-reverse (list 1))
; Input: (3 2 1)
; Expected: (1 2 3)
(deep-reverse (list 3 2 1))
; Input: (((3 2 1)))
; Expected: (((1 2 3)))
(deep-reverse (list (list (list 3 2 1))))
; Input: ((1 2) (3 4))
; Expected: ((4 3) (2 1))
(deep-reverse (list (list 1 2) (list 3 4)))
; Input: ((3) (2) (1))
; Expected: ((1) (2) (3))
(deep-reverse (list (list 3) (list 2) (list 1)))
; Input ((9 8 7) (6 5 4) (3 (2 (1))))
; Expected: ((((1) 2) 3) (4 5 6) (7 8 9))
(deep-reverse (list (list 9 8 7) (list 6 5 4) (list 3 (list 2 (list 1)))))
