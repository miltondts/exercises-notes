;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 168-structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 168

; Lop (short for list-of-posns) is on of:
; '()
; (cons Posns Lop)
; interpretation: an instance of Lop represents a list of (x, y) coordinates

(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 2 3) '())) (cons (make-posn 2 4) '()))

; List-of-posn -> List-of-posn 
(define (translate lop)
  (if (empty? lop)
      '()
      (cons
       (make-posn (posn-x (first lop)) (+ (posn-y (first lop)) 1))
       (translate (rest lop)))))