;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 205-real_world_data_itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 205

; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
 
; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; 
; An Association is a list of two items: 
;   (cons String (cons BSDN '()))

(define-struct date [year month day hour minute second])
; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).

; A BSDN is one of: 
; – Boolean
; – Number
; – String
; – Date

(define ASSOC1 (cons "Free" (cons #false '())))
(define ASSOC2 (cons "Track#" (cons 2 '())))
(define ASSOC3 (cons "Track" (cons "Bongo Bongo Bongo" '())))
(define ASSOC4 (cons "Last-played" (cons (make-date 1970 12 12 12 12 12) '())))
(define ASSOC5 (cons "Free" (cons #true '())))
(define ASSOC6 (cons "Track#" (cons 1 '())))
(define ASSOC7 (cons "Track" (cons "Saudade" '())))
(define ASSOC8 (cons "Last-played" (cons (make-date 1972 12 17 9 1 12) '())))

(define LASSOC1 (list ASSOC1 ASSOC2 ASSOC3 ASSOC4))
(define LASSOC2 (list ASSOC5 ASSOC6 ASSOC7 ASSOC8))

(define LLIST (list LASSOC1 LASSOC2))