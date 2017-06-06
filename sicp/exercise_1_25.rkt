#lang scheme

(define (square x) (* x x))

(define (expmod.v1 base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod.v1 base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod.v1 base (- exp 1) m))
          m))))

(define (expmod.v2 base exp m)
  (define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))
  (remainder (fast-expt base exp) m))

; Alyssa is correct, both procedures serve for our fast prime tester.
; Both versions of expmode need to calculate the exponential before applying
; the remainder and only need m in the final calculation.
; Which means that the code is basically the same, it is just abstracted in
; a different way.
; This is even clearer if we rename n as exp and b as base:
(define (fast-expt base exp)
  (cond ((= exp 0) 1)
        ((even? exp) (square (fast-expt base (/ exp 2))))
        (else (* base (fast-expt exp (- exp 1))))))

(define (expmod.v3 base exp m)
  (remainder (fast-expt base exp) m))
