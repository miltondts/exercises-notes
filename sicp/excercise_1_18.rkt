#lang scheme

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(define (even? a)
  (= (remainder a 2) 0))

(define (double a)
  (+ a a))

; Number -> Number
; Calculate the halve of a number
(define (halve a)
  (/ a 2))

(define (mult-iter product a b)
  (cond ((= b 0) product)
        ((even? b) (mult-iter product (double a) (halve b)))
        (else (mult-iter (+ a product) a (- b 1)))))

(define (fast-mult a b)
  (mult-iter 0 a b))
