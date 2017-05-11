#lang scheme

(define (gcd a b)
 (if (= b 0)
     a
     (gcd b (remainder a b))))

; Normal Order Evaluation (Lazy evaluation)
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (remainder 206 40)))
(gcd 40 (remainder 206 40))
(gcd 40 6)
(if (= 6 0) 6 (gcd 6 (remainder 40 6)))
(gcd 6 (remainder 40 6))
(gcd 6 4)
(if (= 4 0) 6 (gcd 4 (remainder 6 4)))
(gcd 4 (remainder 6 4))
(gcd 4 2)
(if (= 2 0) 4 (gcd 2 (remainder 4 2)))
(gcd 2 (remainder 4 2))
(gcd 2 0)
(if (= 2 0) 2 (gcd 0 (remainder 2 0)))
2

; Applicative Order Evaluation (Strict evaluation)
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 (remainder 206 40)))
(if (= 40 0) 206 (gcd 40 6))
(if (= 6 0) 40 (gcd 6 (remainder 40 6)))
(if (= 6 0) 40 (gcd 6 4))
(if (= 4 0) 6 (gcd 4 (remainder 6 4)))
(if (= 4 0) 6 (gcd 4 2))
(if (= 2 0) 4 (gcd 2 (remainder 4 2)))
(if (= 2 0) 4 (gcd 2 0))
; (if (= 0 0) 2 (gcd 0 (remainder 2 0))) => Undefined for 0







