(define (flip-horiz painter) (transform-painter painter
  (make-vect 1.0 0.0)
  (make-vect 0.0 0.0)
  (make-vect 1.0 1.0)
))

(define (rot-180-ccw painter) (transform-painter painter
  (make-vect 1.0 1.0)
  (make-vect 0.0 1.0)
  (make-vect 1.0 0.0)
))

(define (rot-270-ccw painter) (transform-painter painter
  (make-vect 0.0 1.0)
  (make-vect 0.0 0.0)
  (make-vect 1.0 1.0)
))
