#lang scheme

(define NTIMES 1000)
(define NEXEC 1000)

(define (runtime) (current-milliseconds))

; Number -> Number
; Calculate the square of n
(define (square n)
  (* n n))

; Number Number Number -> Number
; Compute the exponential of a number modulo another number
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

; Number -> Bool
; Test if a number is prime (by picking a random number a checking the
; congruent modulo of n)
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

; Number Number -> Bool
; Check if a number n is prime a given number of times
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

; Number -> "Display"
; Print the number n, followed by if it is prime or not
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime) NEXEC))

; Number Number Number -> "Display"/Bool
; Check if a number if prime, printing the elapsed time if true
; or false otherwise. Execute this action count number of times.
(define (start-prime-test n start-time count)
  (cond
    ((and (fast-prime? n NTIMES) (> count 0)) (start-prime-test n start-time (- count 1)))
    ((= count 0) (report-prime (- (runtime) start-time)))
    (else  #f)))

; Number -> "Display"
; Print *** followed by elapsed-time
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(timed-prime-test 1009)
(timed-prime-test 1013)
(timed-prime-test 1019)
(timed-prime-test 10007)
(timed-prime-test 10009)
(timed-prime-test 10037)
(timed-prime-test 100003)
(timed-prime-test 100019)
(timed-prime-test 100043)
(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)

; R: I would the expect the time to test primes near 1000000 would be
; (log (/ 1000000 1000)) (i.e ~ 6.9) times larger than near 1000
; However, this number does not turn out, regardless of the number of
; times (NTIMES) the fermat test is run.
; This can be explained by ...