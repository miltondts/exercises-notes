;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 285-abstracting_with_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 285

; 1 € = 1.06 $
(define EXCHANGE-RATE 1.06)

(check-expect (convert-euro (list 1.06)) (list 1))
(check-expect (convert-euro (list 2.12 3.18)) (list 2 3))

; List-of-floats -> List-of-floats
; converts a list of US$ into a list of €
(define (convert-euro lof)
  (map
   (lambda (x) (/ x EXCHANGE-RATE))
     lof))

(check-expect (convertFC (list 212 32)) (list 100 0))

; List-of-floats -> List-of-floats
; converts a list of Fahrenheit measurements to a list of Celsius measurements
(define (convertFC lof)
  (map
   (lambda (x) (/ (- x 32) 1.8))
   lof))

(check-expect (translate (list (make-posn 4 2))) (list (list 4 2)))

; List-of-posn -> List-of-pairs-of-numbers
;  translates a list of Posns into a list of list of pairs of numbers
(define (translate lop)
  (map (lambda (p) (list (posn-x p) (posn-y p))) lop))