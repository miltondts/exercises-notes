#lang scheme

(define (count-change amount) (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1)) (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 10)
(cc 10 5)
(cond ((= 10 0) 1) ((or (< 10 0) (= 5 0)) 0) (else (+ (cc 10 (- 5 1)) (cc (- 10 (first-denomination 5)) 5))))
(+ (cc 10 4) (cc (- 10 50) 5))
(+ (+ (cc 10 (- 4 1)) (cc (- 10 (first-denomination 4)) 4)) (cc -40 5))
(+ (+ (cc 10 3) (cc (- 10 25) 4)) 0)
(+ (+ (cc 10 3) (cc -15 4)) 0)
(+ (+ (+ (cc 10 (- 3 1)) (cc (- 10 (first-denomination 3)) 3)) 0) 0)
(+ (+ (+ (cc 10 2) (cc (- 10 10) 3)) 0) 0)
(+ (+ (+ (cc 10 2) (cc 0 3)) 0) 0)
(+ (+ (+ (cc 10 2) 1) 0) 0)
(+ (+ (+ (+ (cc 10 (- 2 1)) (cc (- 10 (first-denomination 2)) 2)) 1) 0) 0)
(+ (+ (+ (+ (cc 10 1) (cc (- 10 5) 2)) 1) 0) 0)
(+ (+ (+ (+ (cc 10 1) (cc 5 2)) 1) 0) 0)
(+ (+ (+ (+ (+ (cc 10 (- 1 1)) (cc (- 10 (first-denomination 1)) 1)) (+ (cc 5 (- 2 1)) (cc (- 5 (first-denomination 2)) 2))) 1) 0) 0)
(+ (+ (+ (+ (+ (cc 10 0) (cc (- 10 1) 1)) (+ (cc 5 1) (cc (- 5 5) 2))) 1) 0) 0)
(+ (+ (+ (+ (+ (cc 10 0) (cc 9 1)) (+ (cc 5 1) (cc 0 2))) 1) 0) 0)
(+ (+ (+ (+ (+ 0 (cc 9 1)) (+ (cc 5 1) 1)) 1) 0) 0)
(+ (+ (cc 9 1) (+ (cc 5 1) 1)) 1)
(+ (+ (+ (cc 9 (- 1 1)) (cc (- 9 (first-denomination 1)) 1)) (+ (+ (cc 5 (- 1 1)) (cc (- 5 (first-denomination 1)) 1)) 1)) 1)
(+ (+ (+ (cc 9 0) (cc (- 9 1) 1)) (+ (+ (cc 5 0) (cc (- 5 1) 1)) 1)) 1)
(+ (+ (cc 8 1) (+ (+ (cc 5 0) (cc 4 1)) 1)) 1)
(+ (+ (cc 8 1) (+ (+ 0 (cc 4 1)) 1)) 1)
(+ (+ (cc 8 1) (+ (cc 4 1) 1)) 1)
(+ (+ (cc 7 1) (+ (+ (cc 4 (- 1 1)) (cc (- 4 (first-denomination 1)) 1)) 1)) 1)
(+ (+ (cc 7 1) (+ (+ (cc 4 0) (cc 3 1)) 1)) 1)
(+ (+ (cc 7 1) (+ (+ 0 (cc 3 1)) 1)) 1)
(+ (+ (cc 6 1) (+ (cc 2 1) 1)) 1)
(+ (+ (cc 5 1) (+ (cc 1 1) 1)) 1)
(+ (+ (cc 4 1) (+ (cc 0 1) 1)) 1)
(+ (+ (cc 4 1) 2) 1)
(+ (+ (cc 3 1) 2) 1)
(+ (+ (cc 2 1) 2) 1)
(+ (+ (cc 1 1) 2) 1)
(+ (+ (cc 0 1) 2) 1)
(+ (+ 1 2) 1)


   




















