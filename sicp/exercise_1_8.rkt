#lang scheme

; Number Number -> Number
; Improve guess

; Number -> Number
; Calculate cube root of x
(define (cube-root x)
  (define (cube-root-iter p-guess guess)
  (if (good-enough? p-guess guess)
      guess
      (cube-root-iter guess (improve guess))))
  (define (good-enough? p-guess guess)
    (< (abs (- p-guess guess)) 1e-10))
  (define (improve y)
    (/ (+ (/ x (* y y)) (* 2 y)) 3))
  (cube-root-iter 2.0 1.0))

; Number Number -> Number
; Aproximate the value of the cube root of x with guess


; Number Number -> Boolean
; Verify guess is close enough to the cube root of x

