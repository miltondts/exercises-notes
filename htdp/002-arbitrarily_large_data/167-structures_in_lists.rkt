;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 167-structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 167

; Lop (short for list-of-posns) is on of:
; '()
; (cons Posns Lop)
; interpretation: an instance of Lop represents a list of (x, y) coordinates

(define ex1 (make-posn 1 2))
(define ex2 (make-posn 4 2))
(define ex3 (make-posn 3 3))

(check-expect (sum '()) 0)
(check-expect (sum (cons ex1 (cons ex2 '()))) 5)
(check-expect (sum (cons ex1 (cons ex3 (cons ex2 '())))) 8)

; List-of-posns -> Number
(define (sum lop)
  (if (empty? lop)
      0
      (+ (posn-x (first lop)) (sum (rest lop)))))