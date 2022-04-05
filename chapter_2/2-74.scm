; Here I'm assuming a division file is just a file name, and that all packages
; from the division files have been installed. It's not exactly clear in the
; question what a "division file" is. An alternative way of defining a division
; file is to state that it is a procedure installing its package which returns
; the division type tag.

; a) The division files must expose a package that installs a procedure that
; finds a record by name under the 'get-record operator and the division type
; tag. This procedure should return '() if not found.
(define (get-record name division)
  ((get 'get-record division) name)
)

; b) Similarly, the division file should expose a package that installs a
; procedure finding salary by record under the 'get-salary operator and the
; division type tag. Procedure should return '() if not found.
(define (get-salary record division)
  ((get 'get-salary division) record)
)

; c) returns null if not found
(define (find-employee-record name divisions)
  (if (null? divisions)
    '()
    (let ((record (get-record name (car divisions))))
      (if (null? record)
        (find-employee-record name (cdr divisions))
        record
      )
    )
  )
)

; d) New packages need to be installed that add the 'get-record and 'get-salary
; procedures under new type tags.
