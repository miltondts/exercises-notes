;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 289-abstracting_with_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 289

(check-expect (find-name "bob" (list "jane" "joe" "bob")) #true)
(check-expect (find-name "jane" (list "bob" "janet" "joe")) #true)
(check-expect (find-name "jane" (list "art" "joe" "bob")) #false)
; String List-of-String -> Boolean
; Determines whether any of the names on the latter are equal to or an
; extension of the former
(define (find-name name lnames)
  (ormap (lambda (x) (string-contains? name x)) lnames))


(check-expect (names-start-with-a (list "andre" "augustus")) #true)
(check-expect (names-start-with-a (list "bajesus" "roberto")) #false)
; String List-of-Strings -> Boolean
; Checks if names on a list of names start with the letter "a".
(define (names-start-with-a lnames)
  (andmap (lambda (x) (string=? "a" (first (explode x)))) lnames))

; Should you use ormap or andmap to define a function that ensures that no name on some list exceeds some given width?
; Both
; andmap -> Check if all items are under the width. If at least one name exceeds a given width, return #false 
; ormap -> If at least one name exceeds a given width, return #true