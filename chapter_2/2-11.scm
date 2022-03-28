; INCORRECT
; DO NOT USE

(define (make-interval a b)
  (cons a b)
)

(define (upper-bound i)
  (max (car i) (cdr i))
)

(define (lower-bound i)
  (min (car i) (cdr i))
)

(define (mul-interval x y) (let
  (
    (p1 (* (lower-bound x) (lower-bound y)))
    (p2 (* (upper-bound x) (lower-bound y)))
    (p3 (* (lower-bound x) (upper-bound y)))
    (p4 (* (upper-bound x) (upper-bound y)))
  )
  (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))
))

(define n? negative?)
; really non-negative, but we are not considering the edge cases of 0
(define (p? x) (not (negative? x)))

(define (max-abs a b)
  (if (= (abs a) (max (abs a) (abs b))) a b)
)
(define (min-abs a b) (min (abs a) (abs b)))

; Internal definitions named according to the equation 
; [a, b] x [c, d] = [e, f]
(define (bens-mul-interval x y)
  (let ((a (lower-bound x))
        (b (upper-bound x))
        (c (lower-bound y))
        (d (upper-bound y)))
    (let ((ap (p? a))
          (bp (p? b))
          (cp (p? c))
          (dp (p? d))
          (an (n? a))
          (bn (n? b))
          (cn (n? c))
          (dn (n? d)))
      (let (
            ; Case 1: a, b, c, d > 0 
            (c1 (and ap bp cp dp))
            ; Case 2: a, b, c, d < 0
            (c2 (and an bn cn dn))
            ; Case 3: a < 0 or b, c, d < 0
            (c3 (or (and an bp cp dp)
                    (and ap bn cn dn)))
            ; Case 4: b < 0 or a, c, d < 0
            (c4 (or (and ap bn cp dp)
                    (and an bp cn dn)))
            ; Case 5: c < 0 or a, b, d < 0
            (c5 (or (and ap bp cn dp)
                    (and an bn cp dn)))
            ; Case 6: d < 0 or a, b, c < 0
            (c6 (or (and ap bp cp dn)
                    (and an bn cn dp)))
            ; Case 7: a < 0, b < 0
            (c7 (and an bn cp dp))
            ; Case 8: c < 0, d < 0
            (c8 (and ap bp cn dn))
            ; Case 9: fallthrough
            ; (cases a, c < 0; b, d < 0; a, d < 0; b, c < 0)
          )
        (cond (c1 (make-interval (* (min a b) (min c d)) (* (max a b) (max c d))))
              (c2 (make-interval (* (max a b) (max c d)) (* (min a b) (min c d))))
              (c3 (make-interval (* a (max-abs c d)) (* b (max-abs c d))))
              (c4 (make-interval (* b (max c d)) (* a (min c d))))
              (c5 (make-interval (* (max a b) c) (* (max a b) d)))
              (c6 (make-interval (* (max a b) d) (* (max a b) c)))
              (c7 (make-interval (* (min a b) (max c d)) (* (max a b) (min c d))))
              (c8 (make-interval (* (max a b) (min c d)) (* (min a b) (max c d))))
              (else (let ((p1 (* a c))
                          (p2 (* a d))
                          (p3 (* b c))
                          (p4 (* b d)))
                (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))
              ))
        )
      )
    )
  )
)

(define (interval-eql? i1 i2)
  (and (= (lower-bound i1) (lower-bound i2)) (= (upper-bound i1) (upper-bound i2)))
)

(define (test-mul i1 i2) (interval-eql? (mul-interval i1 i2) (bens-mul-interval i1 i2)))

; Case 1
(test-mul (cons +1 +2) (cons +3 +4))

; Case 2
(test-mul (cons -1 -2) (cons -3 -4))

; Case 3
(mul-interval (cons +1 -2) (cons -3 -4))
(bens-mul-interval (cons +1 -2) (cons -3 -4))
(test-mul (cons -1 +2) (cons +3 +4))
(test-mul (cons +1 -2) (cons -3 -4))
