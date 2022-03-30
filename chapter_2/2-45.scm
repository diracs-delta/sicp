(define (split p1 p2)
  (define (splitter painter n)
    (if (= n 0)
      painter
      (let ((smaller (splitter painter (- n 1))))
        (p1 painter (p2 smaller smaller))
      )
    )
  )
  splitter
)