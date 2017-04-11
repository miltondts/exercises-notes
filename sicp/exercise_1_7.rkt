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
  (< (abs (- (square guess) x)) 0.01))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)
(sqrt (+ 100 37))
(sqrt (+ (sqrt 2) (sqrt 3)))
(square (sqrt 1000))


(sqrt 0.001) ; => 0.06772532736082602 vs (expected) 0,031622776601684
(sqrt 0.01234); => 0.11752571869070223 vs (expected) 0,111085552615991
(sqrt 1000) ; => 100.00000025490743  vs (expected) 100
(sqrt 998001) ; => 999.0000000000114 vs (expected) 999

