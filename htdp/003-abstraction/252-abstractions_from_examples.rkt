;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 252-abstractions_from_examples) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 252

(require 2htdp/image)

; [List-of Number] -> Number
(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product
          (rest l)))]))
	
; [List-of Posn] -> Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else
     (place-dot
      (first l)
      (image* (rest l)))]))
 
; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))


; 1) Find the similarities
; -> image* and product are basically the same
; they onli differ in the name of the function,
; the return value of the (empty? ...) clause
; and the function aplied to the else statement

; 2) Abstract
(define (fold2 f l end)
    (cond
    [(empty? l) end]
    [else
     (f
      (first l)
      (fold2 f (rest l) end))]))

; 3) Test
(check-expect (product (list 1 2 3)) (fold2 * (list 1 2 3) 1))
(check-expect (image* (list (make-posn 1 2) (make-posn 3 3) (make-posn 4 2)))
              (fold2
               place-dot
               (list (make-posn 1 2) (make-posn 3 3) (make-posn 4 2))
               emt))

; 4) Write the new function signature
; [List-of Number/Posn -> Number/Image] [List-of Number/Posn] Number/Image -> Number/Image