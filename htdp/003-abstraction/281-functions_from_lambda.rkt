;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 281-functions_from_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 281

(define THRESHOLD 10)

(check-expect (LAMBDA1 5) #true)
(check-expect (LAMBDA1 10) #false)
(check-expect (LAMBDA1 15) #false) 
; consumes a number and decides whether it is less than 10
(define LAMBDA1 (lambda (x) (< x THRESHOLD)))

(check-expect (LAMBDA2 1 2) "2")
(check-expect (LAMBDA2 5 5) "25")
; multiplies two given numbers and turns the result into a string
(define LAMBDA2
  (lambda (x y) (number->string (* x y))))

(check-expect (LAMBDA3 2) 0)
(check-expect (LAMBDA3 3) 1)
; consumes a natural number and returns 0 it is even and 1 if odd
(define LAMBDA3
  (lambda (x)
    (if (= 0 (remainder x 2))
        0
        1)))

; consumes two inventory records and compares them by price
(define LAMBDA4
  (lambda (ir) (<= (ir-price ir) THRESHOLD)))

; adds a red dot at a given Posn to a given Image
(define LAMBDA5
  (lambda (position image) ...))