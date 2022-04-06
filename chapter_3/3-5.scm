(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0)
)

(define (area x1 x2 y1 y2)
  (* (abs (- x2 x1)) (abs (- y2 y1)))
)

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral p x1 x2 y1 y2 n)
  (define (test)
    (p (random-in-range x1 x2) (random-in-range y1 y2))
  )
  (* (monte-carlo n test) (area x1 x2 y1 y2))
)

(define (in-unit-circle? x y)
  (<= (+ (* x x) (* y y)) 1)
)

(define (calc-pi n) (estimate-integral in-unit-circle? -1.0 1.0 -1.0 1.0 n))

(calc-pi 100000)
