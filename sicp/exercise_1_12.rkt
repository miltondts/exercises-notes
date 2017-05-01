#lang scheme

; Exercise 1.12

; Number Number -> Number
; Get a given number from the Pascal Triangle from row row and column col
(define (pascal-pos row col)
    (cond
      ((> col row) #f)
      ((or (= col 0) (= col row)) 1)
      (else
       (+ (pascal-pos (- row 1) (- col 1)) (pascal-pos (- row 1) col)))))

; Number Number -> List
; Given the number and an index of the row, return a list of numbers in that row, up to that index
(define (row-list row col)
    (if (= col 0)
      (cons (pascal-pos row 0) '())
      (cons (pascal-pos row col) (row-list row (- col 1)))))

; Number -> List
; Given the number of the row, return a list with the numbers within than row
(define (pascal-row row)
  (row-list row row))

(define (pascal-triangle row)
  (do ((i 0 (+ i 1)))
    ((= i row) (display (pascal-row i)))  
  (display (pascal-row i)) (newline)))