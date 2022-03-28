(define nil (list))

(define (fringe t)
  (cond ((null? t) nil)
        ((pair? (car t))
          (append (fringe (car t)) (fringe (cdr t)))
        )
        (else
          (append (list (car t)) (fringe (cdr t)))
        )
  )
)

(define x (list (list 1 2) (list 3 4)))

(fringe nil)
(fringe x)
(fringe (list x x))
(fringe (list 5 (list 6 (list 7 (list 8 (list (list (list (list 9)))))))))
