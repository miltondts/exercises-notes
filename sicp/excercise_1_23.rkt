#lang scheme

(define NEXECS 10000)

(define (runtime) (current-milliseconds))

(define (square x)
  (* x x))

; Searching for divisors => O(sqrt(n))
(define (smallest-divisor n) (find-divisor n 2))

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

 (define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime) NEXECS))

(define (start-prime-test n start-time count)
  (cond
    ((and (prime? n) (> count 0)) (start-prime-test n start-time (- count 1)))
    ((= count 0) (report-prime (- (runtime) start-time)))
    (else  #f)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; Number Number -> "display"
; Print the three smallest prime numbers larger than n, and the
; ellapsed time to calculate them
(define (search-for-primes n count)
  (cond
    ((= count 0) (display "\nfinished"))
    ((prime? n) (timed-prime-test n) (search-for-primes (+ n 2) (- count 1)))
    (else
     (if (= (remainder n 2) 0)
         (search-for-primes (+ n 1) count)
         (search-for-primes (+ n 2) count)))))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)

; expected => (sqrt 10) => ~ 3.16

; before:
; 1000 => 25 ms, 24 ms, 24 ms
; 10000 => 75 ms, 79 ms, 75 ms
; 100000 => 324 ms, 276 ms, 285 ms
; 1000000 => 832 ms, 902 ms, 864 ms

; now:
; 1000 => 16 ms, 15 ms, 15 ms
; (now/before) => 0.56, 0.6, 0.6
; average => 0.59

; 10000 => 50 ms, 46 ms, 54 ms
; (now/before) => 0.67, 0.58, 0.72
; average => 0.66

; 100000 => 149 ms, 192 ms, 166 ms
; (now/before) => 0.46, 0.7, 0.58
; average => 0.58

; 1000000 => 516 ms, 463 ms, 494 ms
; (now/before) => 0.62, 0.51, 0.57
; average => 0.57

; The ratio is closer to 1.67 than to 2

