#lang scheme


(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; Here we have a compound procedure with the structure:
;      (define (⟨name⟩ ⟨formal parameters⟩) ⟨body⟩)
; The procedure takes two inputs (numbers) and return 1 output (another number)
; The procedure evaluates if b is, or not, a positive number
;      if it is positive, it is added to a
;      if it is not positive, it is subtracted from a
; Encapsulating this algorithm inside the function header (i.e. a-plus-abs-b)