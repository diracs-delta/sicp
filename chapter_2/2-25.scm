(define (pick-1 l1)
  (car (cdr (car (cdr (cdr l1)))))
)

(define (pick-2 l2)
  (caar l2)
)

(define (pick-3 l3)
  (cadr (cadr (cadr (cadr (cadr (cadr l3))))))
)

(pick-1 (list 1 2 (list 5 7) 9))
(pick-2 (list (list 7)))
(pick-3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
