;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 244-functions_are_values) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 244

; Why are the following expressions now legal?

(define (f x) (x 10))
; This is legal because x can be a function

(define (f x) (x f))
; Given functions and primitives are values,
; this is legal because x can be a function or primitive
; and f can be a String, Boolean, Number, 1String ...

(define (f x y) (x 'a y 'b))
; This is legal if x is a function with 3 inputs or a list
