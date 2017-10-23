;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 188-auxiliary_functions_that_recur) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 188

(define-struct email [from date message])
; A Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time 

(define EMAIL-1 (make-email "John" 1234 "I'm blue"))
(define EMAIL-2 (make-email "Jack" 34 "Abadi"))
(define EMAIL-3 (make-email "Brad" 9999 "Abada"))

(check-expect (sort-by-date> (list EMAIL-1 EMAIL-2)) (list EMAIL-1 EMAIL-2))
(check-expect (sort-by-date> (list EMAIL-3 EMAIL-2 EMAIL-1)) (list EMAIL-3 EMAIL-1 EMAIL-2))
(check-expect (sort-by-name> (list EMAIL-1 EMAIL-2)) (list EMAIL-2 EMAIL-1))
(check-expect (sort-by-name> (list EMAIL-3 EMAIL-2 EMAIL-1)) (list EMAIL-3 EMAIL-2 EMAIL-1))


; List-of-emails-> List-of-emails
; produces a sorted version of loe
(define (sort-by-date> loe)
  (cond
    [(empty? loe) '()]
    [(cons? loe) (insert-date (first loe) (sort-by-date> (rest loe)))]))
 
; Email List-of-emails -> List-of-emails
; inserts n into the sorted list of emails l 
(define (insert-date n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= (email-date n) (email-date (first l)))
              (cons n l)
              (cons (first l) (insert-date n (rest l))))]))

; List-of-emails-> List-of-emails
; produces a sorted version of loe sorted alphabetically by name
(define (sort-by-name> loe)
  (cond
    [(empty? loe) '()]
    [(cons? loe) (insert-name (first loe) (sort-by-name> (rest loe)))]))
 
; Email List-of-emails -> List-of-emails
; inserts n into the sorted list of emails l 
(define (insert-name n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (string<? (email-from n) (email-from (first l)))
              (cons n l)
              (cons (first l) (insert-name n (rest l))))]))



