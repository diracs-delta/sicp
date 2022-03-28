; zero: (f) => (x) => x
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))

(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (f) f) x))))
(lambda (f) (lambda (x) (f x)))

; one: (f) => (x) => f(x)
(define one (lambda (f) (lambda (x) (f x))))

; two: (f) => (x) => f(f(x))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define (plus a b)
  (lambda (f) (lambda (x)
    ((a f) ((b f) x))
  ))
)

; converts a church numeral to an actual integer
(define (cn-to-int n) ((n (lambda (i) (+ i 1))) 0))

(cn-to-int (plus one one))
(cn-to-int (plus one two))
(cn-to-int (plus two two))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Side note -- the SICP implementation of Church numerals can be simplified such
; that each numeral is a simple function accepting two functions. This is a lot
; more obvious and readable IMO.

; custom-zero: (f, x) => x
(define custom-zero (lambda (f x) x))
; custom-one: (f, x) => f(x)
(define custom-one (lambda (f x) (f x)))
; custom-two: (f, x) => f(f(x))
(define custom-two (lambda (f x) (f (f x))))

(define (custom-plus a b)
  (lambda (f x)
    (a f (b f x))
  )
)

; converts my custom implementation of Church numerals to an actual integer
(define (custom-to-int n) (n (lambda (i) (+ i 1)) 0))

(custom-to-int custom-zero)
(custom-to-int custom-one)
(custom-to-int custom-two)
(custom-to-int (custom-plus custom-two custom-two))
