;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 140-finger_exercises-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 140

; 1) Define the data
; A List-of-booleans is one of:
; - '()
; - (cons Boolean List-of-booleans)

; 2) Write the function signature, header and purpose statement
; Boolean -> Boolean
; determines whether all elements in a List-of-booleans are true
; (define (all-true lob) ...)

; 3) Write down the examples
(define ex1 (cons #true (cons #true (cons #true '()))))
(define ex2 (cons #true (cons #false '())))
(define ex3 (cons #true (cons #false (cons #true '()))))
(define ex4 '())

; 4) Write the template
;(define (all-true lob)
;  (cond
;    [(empty? lob) ...]
;    [else (... (first lob) ... (all-true (rest lob)) ...)]))

; 5) Fill the template
(define (all-true lob)
  (cond
    [(empty? lob) #true]
    [else (and (first lob) (all-true (rest lob)))]))

; 6) Write the tests
(check-expect (all-true ex1) #true)
(check-expect (all-true ex2) #false)
(check-expect (all-true ex3) #false)
; (check-expect (all-true ex4) #false) => This edge-case is not correct. I need to redesign the function