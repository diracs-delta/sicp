;; a) The procedures for computing derivatives of sums and products was moved
;out into separate procedures that can be called with a (get) dispatching by
;operator. This cannot be done for numbers and variables as they do not have a
;data tag that allows for dispatching by operator.

; b)

(define (install-sum-package)
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  
  (define (calc-sum operator operands var)
    (make-sum (deriv (addend operands) var) (deriv (augend operands) var))
  )
  (put 'deriv '+ calc-sum)
)

(define (install-prod-package)
  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  
  (define (calc-prod operator operands var)
    (make-sum (deriv (multiplier operands) var) (deriv (multiplicand operands) var))
  )
  (put 'deriv '* calc-prod)
)

;; d)
;; We just switch '* and 'deriv in all calls to put.
