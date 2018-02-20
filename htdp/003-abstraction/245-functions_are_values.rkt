;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 245-functions_are_values) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 245

(define (f-test-1 x) x)
(define (f-test-2 x) (* 2 x))

(check-expect (function=? f-test-1 f-test-1) #true)
(check-expect (function=? f-test-1 f-test-2) #false)
; Function Function -> Boolean
; determines whether two functions produce
; the same results for 1.2, 3, and -5.775.
(define (function=? f1 f2)
  (and
   (= (f1 1.2) (f2 1.2))
   (= (f1 3) (f2 3))
   (= (f1 -5.775) (f2 -5.775))))

; It is possible but it would take too much computational cost to
; validate the both function against every possible value