; returns value of the argument from previous invocation. if none, returns 0
(define f
  (let ((curr 0))
    (lambda (n)
      (let ((prev curr))
        (set! curr n)
        prev
      )
    )
  )
)

; when evaluated LTR:
; => evaluates to 0 + 0 = 0
; when evaluated RTL:
; => evaluates to 0 + 1 = 1

; returns 1. hence scheme evaluates arguments RTL.
(+ (f 0) (f 1))

; can verify by uncommenting this:
; (+ (f 1) (f 0))