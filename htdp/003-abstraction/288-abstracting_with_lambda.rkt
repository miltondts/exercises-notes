;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 288-abstracting_with_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 288

; [X] N [N -> X] -> [List-of X]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
; (build-list n f) == (list (f 0) ... (f (- n 1)))

(check-expect (natural-numbers 5) (list 0 1 2 3 4))
; Number -> List-of-Number
; creates the list (list 0 ... (- n 1)) for any natural number n
(define (natural-numbers n)
  (build-list n (lambda (x) x)))

(check-expect (non-zero-natural-numbers 5) (list 1 2 3 4 5))
; Number -> List-of-Number
; creates the list (list 1 ... n) for any natural number n
(define (non-zero-natural-numbers n)
  (build-list n (lambda (x) (add1 x))))

(check-expect (divide-by-natural 2) (list 1 0.5))
; Number -> List-of-Number
; creates the list (list 1 1/2 ... 1/n) for any natural number n
(define (divide-by-natural n)
  (build-list n (lambda (x) (/ 1 (add1 x)))))

(check-expect (first-even 5) (list 0 2 4 6 8))
; Number -> List-of-Number
; creates the list of the first n even numbers
(define (first-even n)
  (build-list n (lambda (x) (* x 2))))

(check-expect (identityM-line 1 3) (list 0 1 0)) 
(check-expect (identityM-line 1 2) (list 0 1))
; Number Number -> [List-of Number]
; Creates a line of an identity matrix
(define (identityM-line i n)
  (build-list n (lambda (j) (if (= i j) 1 0))))

(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
; Number -> [List-of [List-of Number]]
; creates diagonal squares of 0s and 1s
(define (identityM n)
  (build-list n (lambda (x) (identityM-line x n))))

(check-expect (tabulate sqr 2) (list 4 1 0))
(check-expect (tabulate add1 2) (list 3 2 1))
; Function Number -> List-of Numbers
; tabulate a function between between n and 0 (incl.) in a list
(define (tabulate f n)
  (map f (reverse (build-list (add1 n) (lambda (x) x)))))