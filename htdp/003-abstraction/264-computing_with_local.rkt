;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 264-computing_with_local) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 264

(check-expect (sup (list 2 1 3)) 3)
; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (local ((define largest-in-rest (sup (rest l))))
     (if (> (first l) largest-in-rest)
         (first l)
         largest-in-rest))]))

(sup (list 2 1 3))