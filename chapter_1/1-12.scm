; Computes an entry in Pascal's triangle given a row (0-indexed) and a column
; (0-indexed). This necessarily requires c <= r.
(define (pascal r c) (cond
	((= c 0) 1)
	((= c r) 1)
	(else (+ (pascal (- r 1) c) (pascal (- r 1) (- c 1))))
))

(pascal 4 2)
