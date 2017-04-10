;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname string_rest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 37
; String -> String (function signature)
; produces a string like the given one with the first character removed (purpose statement)
; given: "alfie", expect: "lfie" 
; given: "santa"; expect: "anta"
(define (string-rest str) (substring str 1))

(string-rest "alfie")
(string-rest "santa")