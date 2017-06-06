#lang scheme

(define NEXECS 10000)

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

; 1000 => 25 ms, 24 ms, 24 ms
; 10000 => 75 ms, 79 ms, 75 ms
; ratio (i.e. t(10000)/t(1000) => 3, 3.29, 3.01
; difference from expected => -0.16, 0.13, -0.15

; 100000 => 324 ms, 276 ms, 285 ms
; 1000000 => 832 ms, 902 ms, 864 ms
; ratio (i.e. t(1000000)/t(100000) => 2.56, 3.26, 3.03
; difference from expected => -0.6, 0.10, -0.13

; Between 1000 and 10000, the timings do not increase
; exactly by (sqrt 10) but the difference between the
; expected result and the obtained one is not that big.

; The timings between 100000 and 1000000 have an edge value
; that is very different from expected (i.e. 832 ms), but
; in general are very simillar to the expected result.

; These results validate that programs run in time proportional
; to the number of steps they require