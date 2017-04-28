#lang scheme

; Exercise 1.12

; Number Number -> Number
; Get a given number from the Pascal Triangle from row n and position p
; TODO: Remove p and create a list
(define (pascal-pos n p)
    (cond
      ((= p 0) 1)
      ((= p n) 1)
      (else
       (+ (pascal-pos (- n 1) (- p 1)) (pascal-pos (- n 1) p)))))