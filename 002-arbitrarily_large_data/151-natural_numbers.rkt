;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 151-natural_numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 151
; N X -> Number
; multiplies n by x without using *

(check-expect (multiply 3 5) 15)

(define (multiply n x)            ; <= this is the smartass answer. It doesn't use *... but it's basically doing the same
  (/ x (/ 1 n)))


; This is the real answer:
(check-expect (multiply.v2 0 5) 5)
(check-expect (multiply.v2 3 5) 15)

(define (multiply.v2 n x)
  (cond
    [(zero? n) x]
    [else (+ x (multiply (sub1 n) x))]))

; I actually don't remember what the algorithm was back in grade school