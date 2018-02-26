;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 250-abstractions_from_examples) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 250

; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons
      (sin n)
      (tab-sin (sub1 n)))]))
	
; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons
      (sqrt n)
      (tab-sqrt (sub1 n)))]))


; Design recipe
; 1) Find the similarities
;     Both functions have the same signature
;     Both function have the same conditional structure
;     The name of the input parameter is the same
;     The termination clause is practically the same
;    Essential differences => the use of functions sqrt and sin
;    Inessentail differences => the name of the function

; 2) Abstract (replace the differences with new names)
(define (tabulate f n)
  (cond
    [(= n 0) (list (f 0))]
    [else
     (cons
      (f n)
      (tabulate f (sub1 n)))]))

; 3) Test
;(check-expect (tabulate sin 10) (tab-sin 10))
;(check-expect (tabulate sqrt 10) (tab-sqrt 22))

; 4) Get a new signature
; List-of [Number -> [List-of Numbers]] -> List-of Numbers

