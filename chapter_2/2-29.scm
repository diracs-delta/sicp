(define (make-mobile left right) (list left right))
(define (make-branch length structure) (list length structure))

; Test case: mobile with weight of 60
(define m1
  (make-mobile
    (make-branch 1 (make-mobile (make-branch 1 20) (make-branch 1 20)))
    (make-branch 1 20)
  )
)


; Test case: balanced mobile with  weight of 270
(define m2
  (make-mobile
    (make-branch 2 (make-mobile (make-branch 1 60) (make-branch 2 30))) ; w90 l2
    (make-branch 1 (make-mobile (make-branch 1 90) (make-branch 1 90))) ; w180 l1
  )
)

; part A
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cadr mobile))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cadr branch))

;;; extra helpers here to improve readability
(define (left-branch-structure mobile) (branch-structure (left-branch mobile)))
(define (right-branch-structure mobile) (branch-structure (right-branch mobile)))

; part B
(define (total-weight structure)
  (if (pair? structure)
    (+ (total-weight (left-branch-structure structure)) (total-weight (right-branch-structure structure)))
    structure ; if it's not a mobile, structure = weight
  )
)

(total-weight m1) ; expected: 60
(total-weight m2) ; expected: 270

; part C
(define (torque branch)
  (* (total-weight (branch-structure branch)) (branch-length branch))
)

(define (balanced? structure)
  (if (pair? structure)
    (and
      (= (torque (left-branch structure)) (torque (right-branch structure)))
      (balanced? (left-branch-structure structure))
      (balanced? (right-branch-structure structure))
    )
    #t ; if not a mobile, just return true.
  )
)

(balanced? m1)
(balanced? m2)

; part D
; Very little. Just need to change `cadr` to `cdr` in the `right-branch` and
; `branch-structure` selectors.
