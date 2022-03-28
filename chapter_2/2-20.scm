; appends a number to a list
(define (append-number l n) (append l (list n)))

(define (mod2 x) (remainder x 2))

(define (same-parity . l)
  (if (null? l) (error "Must provide at least 1 argument"))

  ; init-parity: parity of initial element: 1 if odd and 0 if even.
  (define init (car l))
  (define init-parity (mod2 init))

  ; accum: accumulated list of elements with matching parity
  ; rem: remaining list of elements to check 
  (define (inner-same-parity accum rem)
    (let ((first (car rem))
          (next-rem (cdr rem)))
      (let ((next-accum (if (= (mod2 first) init-parity) (append-number accum first) accum)))
        (if (null? next-rem) next-accum (inner-same-parity next-accum next-rem))
      )
    )
  )

  (if (null? (cdr l)) (list init) (inner-same-parity (list init) (cdr l)))
)

(same-parity)
(RESTART 1)
(same-parity 1)
(same-parity 1 2 3 4 5 6 7)
(same-parity   2 3 4 5 6 7)