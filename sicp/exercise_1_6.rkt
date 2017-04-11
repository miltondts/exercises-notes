#lang scheme

; When Alyssa tries to use the new sqr-itr procedure the result will be the same.
; The cond-else clause works the same way as the if. That is, if the predicate
; is met, it returns guess, otherwise it will go through (sqr-iter (improve ...) ...)

(define (sqrt-iter.v2 guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

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

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt.v2 x)
  (sqrt-iter.v2 1.0 x))

(sqrt 9)
(sqrt (+ 100 37))
(sqrt (+ (sqrt 2) (sqrt 3)))
(square (sqrt 1000))

(sqrt.v2 9)
(sqrt.v2 (+ 100 37))
(sqrt.v2 (+ (sqrt.v2 2) (sqrt.v2 3)))
(square (sqrt.v2 1000))



