;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname string-last) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 35
; String -> 1String (function signature)
; extracts the last character from str (purpose statement)
; given: "yo mamma", expect: "a"
; given: "foo", expect: "0"
(define (string-last str) (string-ith str (- (string-length str) 1)))
; tests:
(string-last "yo mamma")
(string-last "foo")

