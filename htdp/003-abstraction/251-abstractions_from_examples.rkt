;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 251-abstractions_from_examples) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 251

; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (cond
    [(empty? l) 0]
    [else
     (+ (first l)
        (sum (rest l)))]))

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))


; 1) Find the similarities
; 2) Abstract
(define (fold1 f l end)
  (cond
    [(empty? l) end]
    [else
     (f (first l)
        (fold1 f (rest l) end))]))
; 3) Test
(check-expect (sum (list 1 2 3)) (fold1 + (list 1 2 3) 0))
(check-expect (product (list 3 2 1)) (fold1 * (list 3 2 1) 1))
; 4) Define the new signature
; [Number Number -> Number] List-of-Numbers Number -> Number
