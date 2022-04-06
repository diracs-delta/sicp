(define (attach-tag type-tag contents)
  (if (or (number? contents) (symbol? contents))
    contents
    (cons type-tag contents)
  )
)

(define (type-tag datum)
  (if (or (number? datum) (symbol? datum))
    datum
    (if (pair? datum)
        (car datum)
        (error "Bad tagged datum -- TYPE-TAG" datum))
  )
)

(define (contents datum)
  (if (or (number? datum) (symbol? datum))
    datum
    (if (pair? datum)
        (cdr datum)
        (error "Bad tagged datum -- CONTENTS" datum))
  )
)