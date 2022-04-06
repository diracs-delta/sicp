(define rand
  (let ((x 0))
    (lambda (arg)
      (define (reset new) (set! x new) x)
      (define (generate) (set! x (rand-update x)) x)

      (cond
        ((eq? arg 'generate) (generate))
        ((eq? arg 'reset) reset)
        (else (error "UNKNOWN ARG" arg))
      )
    )
  )
)