;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 236-similarities_in_functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 236

(define LON (list 2 5 9 3 2))
(define LON-2 (list 0 3 7 1 0))
(define LON+1 (list 3 6 10 4 3))
(define LON+5 (list 7 10 14 8 7))

(check-expect (add1* LON) LON+1)
; Lon -> Lon
; adds 1 to each item on l
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (add1 (first l))
       (add1* (rest l)))]))

(check-expect (plus5 LON) LON+5)
; Lon -> Lon
; adds 5 to each item on l
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) 5)
       (plus5 (rest l)))]))

(check-expect (plus-n 1 LON) LON+1)
(check-expect (plus-n 5 LON) LON+5)
; Lon -> Lon
; adds n to each item on l
(define (plus-n n l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (+ (first l) n)
       (plus-n n (rest l)))]))

(check-expect (plus-1 LON) LON+1)
; Lon -> Lon
; adds 1 to each item on l
(define (plus-1 l)
  (plus-n 1 l))

(check-expect (plus-5 LON) LON+5)
; Lon -> Lon
; adds 5 to each item on l
(define (plus-5 l)
  (plus-n 5 l))

(check-expect (minus-2 LON) LON-2)
; Lon -> Lon
; Subtract 2 to each item on l
(define (minus-2 l)
  (cond
    [(empty? l) '()]
    [else
     (cons
       (- (first l) 2)
       (minus-2 (rest l)))]))

; Note: In order to abstract the subtraction function I would need to be able to use
; the function primitive + or - as input


