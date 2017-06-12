;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 160-a_note_on_lists_and_sets) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define test1 (cons 3 (cons 2 (cons 1 '()))))

; Number Son -> Son
(define (in? x s)
  (member? x s))

; Son -> Bool
(define (member-5? s)
  (in? 5 s))

(check-expect (set+.L 4 test1) (cons 4 (cons 3 (cons 2 (cons 1 '())))))
(check-expect (set+.L 3 test1) (cons 3 (cons 3 (cons 2 (cons 1 '())))))
(check-satisfied (set+.L 5 test1) member-5?)
; Number Set.L -> Set.L
; add a number x to a given set s
; for the left hand data definition
(define (set+.L x s)
   (cons x s))

(check-expect (set+.R 4 test1) (cons 4 (cons 3 (cons 2 (cons 1 '())))))
(check-expect (set+.R 3 test1) test1)
(check-satisfied (set+.R 5 test1) member-5?)
; Number Set.R -> Set.R
; add a number x to a given set s
; for the right hand data definition
(define (set+.R x s)
  (if
   (in? x s) s
   (cons x s)))