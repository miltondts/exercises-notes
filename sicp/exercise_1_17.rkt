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

(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (fast-mult (double a) (halve b)))
        (else (+ a (fast-mult a (- b 1))))))
