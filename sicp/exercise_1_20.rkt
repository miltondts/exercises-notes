#lang scheme
(define i 0)

(define (gcd a b)
 (if (= b 0)
     a
     (gcd b
          (begin
            (set! i (+ i 1))
            (remainder a b)))))



