(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
(define (distance p1 p2) (let
  (
    (dx (- (x-point p2) (x-point p1)))
    (dy (- (y-point p2) (y-point p1)))
  )
  (sqrt (+ (square dx) (square dy)))
))

(define (make-segment a b) (cons a b))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
(define (length-segment s) (distance (start-segment s) (end-segment s)))

(define (area r)
  (* (longest-side r) (shortest-side r))
)

(define (perimeter r)
  (+ (* 2 (longest-side r)) (* 2 (shortest-side r)))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Implementation 1 (comment other one out to run)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Defined interally as 2 segments
(define (make-rect-1 s1 s2)
  (cons s1 s2)
)

(define (width r) (car r))
(define (height r) (cdr r))

(define (longest-side r) (let
  (
    (a (length-segment (width r)))
    (b (length-segment (height r)))
  )
  (max a b)
))

(define (shortest-side r) (let
  (
    (a (length-segment (width r)))
    (b (length-segment (height r)))
  )
  (min a b)
))

(define r1 (make-rect-1
  (make-segment (make-point 0 0) (make-point 10 0))
  (make-segment (make-point 0 5) (make-point 10 5))
))

(area r1)
(perimeter r1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Implementation 2 (comment other one out to run)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Defined internally as width (number), height (number), origin (point), and
; angle in radians (number)
(define (make-rect-2 width height origin angle) 
  (cons width (cons height (cons origin angle)))
)

(define (width r) (car r))
(define (height r) (car (cdr r)))

(define (longest-side r) (max (width r) (height r)))
(define (shortest-side r) (min (width r) (height r)))

(define r2 (make-rect-2 10 5 (make-point 0 0) 0))

(area r2)
(perimeter r2)
