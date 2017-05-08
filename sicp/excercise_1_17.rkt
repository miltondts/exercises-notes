#lang scheme

(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))

(define (even? a)
  (= (remainder a 2) 0))

(define (double a)
  (+ a a))

(define (halve-aux a b)
  (if (= (double b) a)
      b
      (halve-aux a (- b 1))))

; Number -> Number
; Calculate the halve of a number
(define (halve a)
  (if (even? a)
      (halve-aux a a)
      #f))

(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (- b 1))))))
