;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; environment definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define nil (list))

; accumulate works backwards with the given sequence. the last element in the
; sequence has the operator applied first.
;
; op accepts two arguments:
; 1. element of the list on this iteration (L_i)
; 2. the accumulated list of results thus far
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) (accumulate op initial (cdr sequence)))
  )
)

(define (enumerate-interval a b)
  (if (> a b)
    nil
    (append (list a) (enumerate-interval (+ a 1) b))
  )
)

(define (flatmap proc seq) (accumulate append nil (map proc seq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; solution code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; empty board is an empty list of positions
(define empty-board nil)

; adds a new position (row, col) to a list of positions
(define (adjoin-position row col positions)
  (cons (cons row col) positions)
)

(define (is-horizontal? p1 p2)
  (let ((r1 (car p1))
        (r2 (car p2)))
    (= r1 r2)
  )
)

(define (is-diagonal? p1 p2)
  (let ((x1 (car p1))
        (x2 (car p2))
        (y1 (cdr p1))
        (y2 (cdr p2)))
    (= (abs (- x2 x1)) (abs (- y2 y1)))
  )
)

; Determines if the queen in column k is safe, given a list of queen positions.
(define (safe? k positions)
  ; first, get the position corresponding to column k and make it the first
  ; element of `positions`.
  (define sorted-positions
    (accumulate
      (lambda (curr accum)
        (if (= (cdr curr) k)
          (cons curr (cdr accum))
          (cons (car accum) (cons curr (cdr accum)))
        )
      )
      (cons nil nil)
      positions
    )
  )
  (define k-pos (car sorted-positions))
  (define filtered-positions (cdr sorted-positions))
  (accumulate
    (lambda (curr accum)
      (and
        accum
        (not (is-diagonal? curr k-pos))
        (not (is-horizontal? curr k-pos))
        ; no need to check for vertical since we are iterating by column and
        ; thus it is guaranteed there only exists one queen per column.
      )
    )
    #t
    filtered-positions
  )
)

(define (queens board-size)
  ; Returns a list of possible queen configurations (which themselves are lists
  ; of queen positions) in the first k columns of a given board.
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board) ; base case k=0; empty list of configurations ()
      (filter
        ; (3) finally filter out all the unsafe positions for the new queen in
        ; column k
        (lambda (positions) (safe? k positions)) 
        ; (2) get list of `board-size` new queen configurations for each
        ; configuration in `(queen-cols (- k 1))` by adding a queen in
        ; `board-size` rows of column k 
        (flatmap
          (lambda (rest-of-queens)
            (map
              (lambda (new-row) (adjoin-position new-row k rest-of-queens))
              (enumerate-interval 1 board-size)
            )
          )
          ; (1) recursively compute list of possible queen configurations for
          ; k - 1
          (queen-cols (- k 1))
        )
      )
    )
  )

  ; Finally, begin the recursive process by calling queen-cols with the given
  ; board-size
  (queen-cols board-size)
)

(queens 4)
(length (queens 8))
