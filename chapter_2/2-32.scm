(define nil '())

; This works when we recognize that the subsets for any index i in L can be
; constructed as:
;
; - All subsets in the list L[i+1 .. n], plus
; - L_i inserted in each of the subsets mentioned above.
; 
; The base case is i = n where (subsets L[n..n]) = (());
;
; For example: evolution of the process' return value for the basic example
; (subsets (1 2)):
;
; (())
; (() (2)) ; take the above set of subsets and insert 2 to each, appending the result
; (() (2) (1) (1 2)) ; take the above set of subsets and insert 1 to each, appending the result
(define (subsets s)
  (if (null? s)
    (list nil)
    (let ((rest (subsets (cdr s))))
      (append rest (map (lambda (e)
        (append (list (car s)) e)
      ) rest))
    )
  )
)

(subsets (list 1 2 3))
(subsets (list 1 2 3 4 5 6 7 8 9 10))
