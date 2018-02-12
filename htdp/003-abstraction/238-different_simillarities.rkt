;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 238-different_simillarities) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 238

(define LIST1
  `(25 24 23 22 21 20 19 18 17 16 15 14 13
      12 11 10 9 8 7 6 5 4 3 2 1))

(define LIST2
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
        17 18 19 20 21 22 23 24 25))

(check-expect (bound < LIST2) 1)
;(check-expect (bound > LIST2) 25)
; Nelon -> Number
; determines the bound on l
(define (bound func l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (func (first l)
            (bound func (rest l)))
         (first l)
         (bound func (rest l)))]))

;(check-expect (inf-1 LIST1) 1)
(check-expect (inf-1 LIST2) 1)
(define (inf-1 l)
  (bound < l))

(check-expect (sup-1 LIST1) 25)
;(check-expect (sup-1 LIST2) 25)
(define (sup-1 l)
  (bound > l))

(check-expect (inf LIST1) 1)
(check-expect (inf LIST2) 1)
; Nelon -> Number
; determines the smallest 
; number on l
(define (inf-2 l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (min (first l) (inf (rest l)))]))

(check-expect (sup LIST1) 25)
(check-expect (sup LIST2) 25)
; Nelon -> Number
; determines the largest 
; number on l
(define (sup-2 l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (max (first l) (sup (rest l)))]))


; The new definitions depend on standard libraries that, ideally, have already
;been optimized in terms of efficiency.
; The first definition has a complexity of O(n^2) given it has to transverse
;and compare the whole list once for each element of the list, the second
;definition compares subsequent elements of the list but only has to go
;through it once (complexity: O(n))
    
