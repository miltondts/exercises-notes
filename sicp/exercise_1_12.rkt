#lang scheme

; Exercise 1.12

; Number Number -> Number
; Get a given number from the Pascal Triangle from row n and position p
(define (pascal-pos n p)
    (cond
      ((= p 0) 1)
      ((= p n) 1)
      (else
       (+ (pascal-pos (- n 1) (- p 1)) (pascal-pos (- n 1) p)))))

; Number Number -> List
; Given the number and an index of the row, return a list of numbers in that row, up to that index
(define (row-list n p)
    (if (= p 0)
      (cons (pascal-pos n 0) '())
      (cons (pascal-pos n p) (row-list n (- p 1)))))

; Number -> List
; Given the number of the row, return a list with the numbers within than row
(define (pascal-row n)
  (row-list n n))

(define (pascal-triangle n)
  (do ((i 0 (+ i 1)))
    ((= i n) (display (pascal-row i)))  
  (display (pascal-row i)) (newline)))