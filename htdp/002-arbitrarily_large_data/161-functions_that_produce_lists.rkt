;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 161-functions_that_produce_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 161

(define WAGE 14)

(define ex1 '())
(define ex2 (cons 28 '()))
(define ex3 (cons 4 (cons 2 '())))

(check-expect (wages* ex1) ex1)
(check-expect (wages* ex2) (cons (* 28 WAGE) '()))
(check-expect (wages* ex3) (cons (* 4 WAGE) (cons (* 2 WAGE) '())))
; List-of-wages -> List-of-wages
; computes the weekly wages for the weekly hours
(define (wages* whrs)
  (cond
    [(empty? whrs) '()]
    [else
     (cons (wage (first whrs)) (wages* (rest whrs)))]))

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* WAGE h))
