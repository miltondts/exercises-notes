#lang scheme

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (square x)
  (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)
(sqrt (+ 100 37))
(sqrt (+ (sqrt 2) (sqrt 3)))
(square (sqrt 1000))

(sqrt 10000) ; => 100.00000025490743  vs (expected) 100
(sqrt 998001) ; => 999.0000000000114 vs (expected) 999
(sqrt 0.001) ; => 0.06772532736082602 vs (expected) 0,031622776601684
(sqrt 0.01234); => 0.11752571869070223 vs (expected) 0,111085552615991

; The good enough method is not very effective in finding the root of very small
;numbers because it has a fixed precision of 0.001. Thus, any number of the same
; order or smaller than 0.001 will be largely affected by the approximation.
; The wheight of the impact of this precision can be calculated by dividing the
; precision by the number we want to root.
; For example
; - (/ 0.001 10000) => 0,000001 => small impact
; - (/ 0.001 0.001) => 1
; - (/ 0.001 0.0001) => 10 => larger impact

; Regarding large numbers, computation in computers are mostly limited by the
;CPU register size and how floating-points are processed. This implies that
;the calculations will be performed with a limited number of decimal points, and
;so the approximations of each step will be propagated throughout the calculation

; To improve good-enough I suggest that the precision of the approximation in
;(< (abs (- (square guess) x)) apx) be decreased so that apx would be, for example,
;0.000000000001. Decreasing it any lower will make the computation extremely slow.

(define (sqrt-iter.v2 guess x)
  (if (good-enough?.v2 guess)
      guess
      (sqrt-iter.v2 (improve guess x) x)))

; Number Number Number -> Bool
; Stop when the change between iterations is a small fraction of a guess
(define (good-enough?.v2 guess)
  (< (abs (/ (- guess (improve guess)) guess) (* guess 0.001))))

(define (sqrt.v2 x)
  (sqrt-iter.v2 1.0 x))

(sqrt.v2 10000)
(sqrt.v2 998001)
(sqrt.v2 0.001)
(sqrt.v2 0.01234)
