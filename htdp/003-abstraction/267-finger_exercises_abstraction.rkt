;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 267-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 267

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
; constructs a list by applying f to each item on lx
; (map f (list x-1 ... x-n)) == (list (f x-1) ... (f x-n))

; 1 € = 1.06 $
(define EXCHANGE-RATE 1.06)


(check-expect (convert-euro (list 1.06)) (list 1))
(check-expect (convert-euro (list 2.12 3.18)) (list 2 3))

; List-of-floats -> List-of-floats
; converts a list of US$ into a list of €
(define (convert-euro lof)
  (local (; Float -> Float
          ; converts US$ to €
          (define (convert-one-amount f)
            (/ f EXCHANGE-RATE)))
    (map convert-one-amount lof)))


(check-expect (convertFC (list 212 32)) (list 100 0))

; List-of-floats -> List-of-floats
; converts a list of Fahrenheit measurements to a list of Celsius measurements
(define (convertFC lof)
  (local (; Float -> Float
          ; converts Fahrenheit to Celsius
          (define (convert-f-to-c f)
            (/ (- f 32) 1.8)))
    (map convert-f-to-c lof)))


(check-expect (translate (list (make-posn 4 2))) (list (list 4 2)))

; List-of-posn -> List-of-pairs-of-numbers
;  translates a list of Posns into a list of list of pairs of numbers
(define (translate lop)
  (local (; Posn -> Pair-of-numbers
          ; converts a position to a pair of numbers
          (define (translate p)
            (list (posn-x p) (posn-y p))))
    (map translate lop)))



