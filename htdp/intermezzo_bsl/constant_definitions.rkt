;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname constant_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 124

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
; (define SALES-TAX (* 0.08 5)) <=> (define SALES-TAX 0.4)
(define TOTAL (+ PRICE SALES-TAX))
; (define TOTAL (+ 5 0.4)) <=> (define TOTAL 5.4)

; ------------------------------------------------------------------------------
; The evaluation of the second program of this exercise signals an error because
; the function fahrenheit->celsius is only defined only after it is called.
; While the third program of this exercise works correctly, given the function f
; is defined before it is used.