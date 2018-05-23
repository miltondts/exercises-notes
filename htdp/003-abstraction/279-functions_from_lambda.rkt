;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 279-functions_from_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 279
; Decide which of the following phrases are legal lambda expressions:

(lambda (x y) (x y y))
; VALID
; lambda gets a sequence of variables where x must be a function accepting
; 2 input arguments

(lambda () 10)
; VALID?
; Always returns 10

(lambda (x) x)
; VALID
; lambda gets a sequence of variables and returns x

(lambda (x y) x)
; VALID
; lambda gets a sequence of two variables and returns x

; (lambda () 10)
; INVALID
; The sequence of variables is not enclosed in a pair of parentheses.

