(define (make-monitored f)
  (let ((count 0))
    (define (inc-and-call a)
      (set! count (+ count 1))
      (f a)
    )
    (define (reset-count) (set! count 0) count)
    
    (define (dispatch a)
      (cond
        ((eq? a 'how-many-calls?) count)
        ((eq? a 'reset-count) (reset-count))
        (else (inc-and-call a))
      )
    )
    dispatch
  )
)

(define (i a) a)

(define mf (make-monitored i))

(mf 'how-many-calls?)
(mf 1)
(mf 1)
(mf 1)
(mf 'how-many-calls?)
(mf 'reset-count)
(mf 'how-many-calls?)
(mf 1)
(mf 'how-many-calls?)