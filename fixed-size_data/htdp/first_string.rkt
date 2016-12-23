;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname first_string) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 34
; String -> 1String (function signature)
; extracts the first character from a non-empty String (purpose statement)
; given: "yo mamma", expects: "y" (example illustration)
; given: "foo", expects "f" (example illustration)
(define (first-string str) (string-ith str 0)) ; (header/stub)
(first-string "yo mamma") ;test1
(first-string "foo") ;test2
(first-string "batman") ;test3 - outsider test