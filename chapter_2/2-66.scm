(define (lookup key tree)
  (cond
    ((or (= key (entry tree)) (null? tree)) tree)
    ((< key (entry tree)) (lookup key (left-branch tree)))
    ; key > entry
    (else (lookup key (right-branch tree)))
  )
)