;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 169-structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 169
(define X_UPPER_BOUND 100)
(define X_LOWER_BOUND 0)
(define Y_UPPER_BOUND 200)
(define Y_LOWER_BOUND 0)

(define ex1 (make-posn 33 42))
(define ex2 (make-posn 33 300))
(define ex3 (make-posn 33 -3))
(define ex4 (make-posn 200 42))
(define ex5 (make-posn -2 42))

(check-expect (legal-posn? ex1) #true)
(check-expect (legal-posn? ex2) #false)
(check-expect (legal-posn? ex3) #false)
(check-expect (legal-posn? ex4) #false)
(check-expect (legal-posn? ex5) #false)

; Validate the posn has x between [0, 100]
; and y [0, 200]
; Posn -> Boolean
(define (legal-posn? p)
  (and
   (and (> (posn-x p) X_LOWER_BOUND) (< (posn-x p) X_UPPER_BOUND))
   (and (> (posn-y p) Y_LOWER_BOUND) (< (posn-y p) Y_UPPER_BOUND))))


(define ex6 '())
(define ex7 (cons ex1 (cons ex2 '())))
(define ex8 (cons ex1 '()))

(check-expect (legal ex6) ex6)
(check-expect (legal ex7) ex8)
(check-expect (legal ex8) ex8)

; Get all the posn with x between [0, 100]
; and y [0, 200]
; List-of-posn -> List-of-posn
(define (legal lop)
  (cond
    [(empty? lop) '()]
    [(legal-posn? (first lop)) (cons (first lop) (legal (rest lop)))]
    [else (rest lop)]))