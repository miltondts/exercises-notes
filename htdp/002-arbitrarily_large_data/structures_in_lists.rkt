;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Stop!

(define-struct work [employee rate hours])
; A (piece of) Work is a structure:
;   (make-work String Number Number)
; interpretation: (make-work n r h) combines the name
; with the pay rate r and the number of hours h

; Low (short for List-of-works) is one of:
;    - '()
;    - (cons Work Low)
; interpretation: an instance of Low represents the
; hours worked for a number of employees

(define element1 '())
(define element2 (cons (make-work "Robby" 11.95 39) '()))
(define element3 (cons (make-work "Matthew" 12.95 45) element2))
; This pieces of data belong to the data definition because they
; encompass an empty list (fulfilling the first item of Low) and
; the remaining elements are of type Work (which contains information
; on hours per employee)

(define element4 (cons (make-work "Abed" 4.95 80) '()))
(define element5 (cons (make-work "Nancy" 10.95 40) (cons (make-work "Monica" 10.85 40) '())))