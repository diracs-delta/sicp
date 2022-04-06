(define (install-raise)
  (define (raise-int int) (make-rational int 1))
  (define (raise-rat rat) (tag 'real (/ (cadr rat) (cddr rat))))
  (define (raise-real real) (make-complex-from-real-imag real 0))

  (put 'raise 'scheme-number raise-int)
  (put 'raise 'rational raise-rat)
  (put 'raise 'real raise-real)
)

(define (raise x) (apply-generic 'raise x))