#lang scheme

(define (square n)
  (* n n))

(define (even n)
  (= (remainder n 2) 0 ))

(define (fast-expt b n)
  (cond
    ((= n 0) 1)
    ((even? n) (fast-expt (square b) (/ n 2)))
    (else (* b (fast-expt b (- n 1))))
    ))
    
; What do I want?
; An interative exponentiation process that uses successive squaring and an logarithmic number of steps

; It must keep => the exponent n, base b and a state variable a;
; At the beggining of the process, a is 1
; The answer is given by the value of a

; Must define the transformation so that the product ab^n is unchanged from state to state

(define (iterative b n)
  (iterative-expt 1 b n))

; FIXME: Still not working
(define (iterative-expt a b n)
  (cond
    ((= n 0) a)
    ((even? n) (iterative-expt a (square b) (/ n 2)))
    (else (iterative-expt (* a b) b (- n 1)))))