; a) apply-generic triggers an infinite loop b/c it continuously attempts to
; coerce x into type y, and then re-evaluate apply-generic.

; b) No.

; c) No changes needed