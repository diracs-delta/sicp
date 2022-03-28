(define (gcd a b) (let ((a-pos (abs a)) (b-pos (abs b)))
  (if
    (= b 0)
    a
    (gcd b (remainder a b))
  )
))

(define (neg x) (* -1 x))
(define (xor a b) (and (or a b) (not (and a b))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (let ((n-reduced (abs (/ n g))) (d-reduced (abs (/ d g))))
      (if
        (xor (< n 0) (< d 0))
        (cons (neg n-reduced) d-reduced)
        (cons n-reduced d-reduced)
      )
    )
  )
)

(make-rat  3  9) ;  1/3
(make-rat -3  9) ; -1/3
(make-rat  3 -9) ; -1/3
(make-rat -3 -9) ;  1/3
