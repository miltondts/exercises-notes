;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 147-non-empty_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 147

(define ex1 (cons #true (cons #true (cons #true '()))))
(define ex2 (cons #true (cons #false '())))
(define ex3 (cons #true (cons #false (cons #true '()))))
(define ex4 '())
(define ex5 (cons #false (cons #false '())))

; a NEList-of-booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-booleans)
; interpretation non-empty list of boolean

(check-expect (all-true ex1) #true)
(check-expect (all-true ex2) #false)
(check-expect (all-true ex3) #false)
(check-error (all-true ex4) "rest: expects a non-empty list; given: '()")
(check-expect (all-true ex5) #false)

; Boolean -> Boolean
; determines whether all elements in a NEList-of-booleans are true
(define (all-true nelob)
  (cond
    [(empty? (rest nelob)) (first nelob)]
    [else (and (first nelob) (all-true (rest nelob)))]))

(check-expect (one-true ex1) #true)
(check-expect (one-true ex2) #true)
(check-expect (one-true ex3) #true)
(check-error (one-true ex4) "rest: expects a non-empty list; given: '()")
(check-expect (one-true ex5) #false)

; List-of-boolean -> Boolean
; determines whether at least one item in a list is true
(define (one-true nelob)
    (cond
    [(empty? (rest nelob)) (first nelob)]
    [else (or (first nelob) (one-true (rest nelob)))]))