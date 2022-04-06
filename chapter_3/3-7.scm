(define (make-account balance pw)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch input-pw m)
    (if (eq? pw input-pw)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                        m)))
      (error "BAD PASSWORD" input-pw)
    )
  )
  dispatch
)

; this implementation doesn't show errors until withdraw/deposit are attempted.
; having it fail immediately is simple if you add a 'check method that validates
; the password in make-account.
(define (make-joint acc joint-pw orig-pw)
  (lambda (input-pw m)
    (if (eq? input-pw joint-pw)
      (acc orig-pw m)
      (error "BAD PASSWORD" input-pw)
    )
  )
)

(define peter-acc (make-account 100 'teapot))
(define paul-acc (make-joint peter-acc 'spout 'teapot))
(define paulina-acc (make-joint peter-acc 'spout 'wrong-password))

; 90
((peter-acc 'teapot 'withdraw) 10)
; 80
((paul-acc 'spout 'withdraw) 10)

; should error
((paul-acc 'teapot 'withdraw) 10)
((paulina-acc 'spout 'withdraw) 10)
