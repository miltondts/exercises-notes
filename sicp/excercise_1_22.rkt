#lang scheme

(define (runtime) (current-milliseconds))

(define (square x)
  (* x x))

; Searching for divisors => O(sqrt(n))
(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n ) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      #f))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; Number Number -> "display"
; Print the three smallest prime numbers larger than n, and the
; ellapsed time to calculate them
(define (search-for-primes n count)
  (cond
    ((= count 0) (display "\nfinished"))
    ((prime? n) (timed-prime-test n) (search-for-primes (+ n 1) (- count 1)))
    (else (search-for-primes (+ n 1) count))))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)



