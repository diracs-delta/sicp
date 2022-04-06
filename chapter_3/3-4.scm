(define (call-the-cops)
  (display "WEE WOO WEE WOO")
)

(define (make-account balance pw)
  (let ((attempts 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (try-input-pw input-pw)
      (if (eq? pw input-pw)
        (begin
          (set! attempts 0)
          #t
        )
        (begin
          (set! attempts (+ attempts 1))
          #f
        )
      )
    )

    (define (dispatch input-pw m)
      (if (try-input-pw input-pw)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                          m)))
        (if (> attempts 7)
          (begin
            (call-the-cops)
            (error "TOO MANY BAD PASSWORDS! COPS CALLED")
          )
          (error "BAD PASSWORD" input-pw)
        )
      )
    )
    dispatch
  )
)

(define acc (make-account 100 'teapot))

((acc 'pottea 'deposit) 100)
((acc 'teapot 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
((acc 'pottea 'deposit) 100)
