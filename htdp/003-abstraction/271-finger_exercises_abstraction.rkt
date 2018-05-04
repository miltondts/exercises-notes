;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 271-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 271

; [X] [X -> Boolean] [List-of X] -> Boolean
; determines whether p holds for at least one item on lx
; (ormap p (list x-1 ... x-n)) == (or (p x-1) ... (p x-n))
; (define (ormap p lx) ...)


(check-expect (is-mine-bigger? "str" "string") #false)
(check-expect (is-mine-bigger? "banana" "str") #true)
(check-expect (is-mine-bigger? "str" "str") #false)
; String String -> Boolean
; Check if mine is lengthier than yours
(define (is-mine-bigger? mine yours)
  (> (string-length mine) (string-length yours)))

(check-expect (is-extension? "str" "string") #true)
(check-expect (is-extension? "str" "banana") #false)
(check-expect (is-extension? "string" "str") #false)
; String String -> Boolean
; Check if str is extension of name
(define (is-extension? name str)
  (if (is-mine-bigger? name str)
      #false
      (string=? name (substring str 0 (string-length name)))))
  
(check-expect (find-name "banana" (list "apple" "orange" "banana")) #true)
(check-expect (find-name "banana" (list "apple" "orange")) #false)
(check-expect (find-name "ban" (list "apple" "banana")) #true)
; String List-of-String -> Boolean
; determines whether any of the String on the List-of-String are equal to or an extension String.
(define (find-name name list-of-names)
  (local
    ((define (is-name? str)
       (if (is-mine-bigger? name str)
        (string=? name str)
        (is-extension? name str))))
  (ormap is-name? list-of-names)))


; [X] [X -> Boolean] [List-of X] -> Boolean
; determines whether p holds for every item on lx
; (andmap p (list x-1 ... x-n)) == (and (p x-1) ... (p x-n))
;(define (andmap p lx) ...)

(check-expect (its-the-same (list "artipod" "blah") ) #false)
(check-expect (its-the-same (list "aardvark" "apricot")) #true)
(check-expect (its-the-same '()) #false)
; List-of-String -> Boolean
; determines whether any of the String on the List-of-String are equal to or an extension String.
(define (its-the-same list-of-names)
  (local
    ((define (starts-with-a? name)
       (string=? "a" (substring name 0 1))))
   (if (empty? list-of-names)
    #false
  (andmap starts-with-a? list-of-names))))

; You can use both andmap or ormap to define a function that ensures that no name on some list exceeds a given width
; You can use ormap to determine if at least one item has a different length
; You can use andmao to determine if all items are the same length