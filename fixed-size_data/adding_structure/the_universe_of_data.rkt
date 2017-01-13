;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname the_universe_of_data) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 76

;(define-struct movie [title producer year])
; Movie is (make-movie String String Number

;(define-struct person [name hair eyes phone])
; Person is (make-person String String String String)

;(define-struct pet [name number])
; Pet is (make-pet String Number)

;(define-struct CD [artist title price])
; CD is (make-cd String String Number)

;(define-struct sweater [material size producer])
; Sweater is (make-sweater String Number String)

; ------------------------------------------------------------------------------
; Exercise 77

(define-struct point-in-time [hours minutes seconds])
; Point-in-time is (make-point-in-time Number Number Number)

; ------------------------------------------------------------------------------
; Exercise 78 - How can I bound the input of a struct???
;               I can define a structure with define-struct but this does not
;             define which type each entry takes. So, how can I bound, while
;             defining a structure, that the input value can only be lower case
;             letters?

;(define-struct 3-letter-word [first second third])
; 3-letter-word is (make-three-letter-word 1String 1String 1String ))

; If I create a setter function to use this structure I can limit the input with
; a cond expression.
; So I can actually just have:
;(define-struct 3-letter-word [word])
; 3-letter-word is (make-three-letter-word String ))
; The eventual insert word function should have:
; - a condition to evaluate the string's length is == to 3
; - each character is a letter
; - each character is lower case
; - return false if any of the previous conditions fail
