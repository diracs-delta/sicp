(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

;; start of 2-70

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
        
(define (element-of-set? x set)
  (cond
    ((null? set) #f)
    ((eq? (car set) x) #t)
    (else (element-of-set? x (cdr set)))
  )
)

(define (encode-symbol symbol tree)
  (define (encode-symbol-int symbol tree bits)
    (let ((left (left-branch tree)) (right (right-branch tree)))
      (cond
        ((and (leaf? left) (eq? (symbol-leaf left) symbol)) (append bits '(0)))
        ((and (leaf? right) (eq? (symbol-leaf right) symbol)) (append bits '(1)))
        ((and (not (leaf? left)) (element-of-set? symbol (symbols left))) (encode-symbol-int symbol left (append bits '(0))))
        ((and (not (leaf? right)) (element-of-set? symbol (symbols right))) (encode-symbol-int symbol right (append bits '(1))))
        (else (error "ERROR: symbol not found in tree:" symbol))
      )
    )
  )

  (encode-symbol-int symbol tree '())
)

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge tree-set)
  (if (null? (cdr tree-set))
    (car tree-set)
    (let ((left (car tree-set)) (right (cadr tree-set)) (rest (cddr tree-set)))
      (let ((new-tree (make-code-tree left right)))
        (successive-merge (adjoin-set new-tree rest))
      )
    )
  )
)

(define tree (generate-huffman-tree '(
  (A 2)
  (BOOM 1)
  (GET 2)
  (JOB 2)
  (NA 16)
  (SHA 3)
  (YIP 9)
  (WAH 1)
)))

(define encoded (encode '(
  GET A JOB
  SHA NA NA NA NA NA NA NA NA
  GET A JOB
  SHA NA NA NA NA NA NA NA NA
  WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
  SHA BOOM
) tree))

(length encoded)

; 84 bits are required for this encoding of 42 words. If a fixed-length encoding
; were used, it would require at least 42 * 3 = 126 bits, since there are 42
; words that require at least 3 bits to represent each uniquely.
;
; Our Huffman tree allows for a 33.3% reduction in message size.
