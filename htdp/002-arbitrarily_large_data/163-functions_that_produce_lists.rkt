;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 163-functions_that_produce_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 163

(define ex1 '())
(define ex2 (cons 1 '()))
(define ex3 (cons 33 (cons 1 '())))


(check-within (to-celsius 1) -17.2 0.05)
; Number -> Number
; converts a measurement in Fahrenheito to a measurement in
; Celsius
(define (to-celsius f)
  (* (- f 32) (/ 5.0 9)))

(check-expect (convertFC ex1) '())
(check-within (convertFC ex2) (cons -17.2 '()) 0.05)
(check-within (convertFC ex3) (cons 0.5 (cons -17.2 '())) 0.06)
; List-of-numbers -> List-of-numbers
; converts a list of measurements in Fahrenheit to a list
; of measurements in Celsius
(define (convertFC lof)
  (if (empty? lof)
      '()
      (cons (to-celsius (first lof)) (convertFC (rest lof)))))