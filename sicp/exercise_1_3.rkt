#lang scheme

; Number Number Number -> Number
; returns the sum of the squares of the 2 larger numbers
(define (sum-squares x y z)
  (cond
    ((or
     (and (> x y z) (> y z))
     (and (> y x z) (> x z)))
     (+ (* x x) (* y y)))
    ((or
     (and (> x y z) (> z y))
     (and (> z x y) (> x y)))
     (+ (* x x) (* z z)))
    (else
     (+ (* y y) (* z z)))))
                             