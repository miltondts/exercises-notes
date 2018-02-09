;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 233-similarities_in_functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 235

(define GOOD-LOS (list "atom" "basic" "zoo"))
(define BAD-LOS (list "mota" "cisab" "ooz"))


; String Los -> Boolean
; determines whether l contains the string s
(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

(check-expect (contains-atom? GOOD-LOS) #true)
(check-expect (contains-atom? BAD-LOS) #false)
(define (contains-atom? l)
  (contains? "atom" l))

(check-expect (contains-basic? GOOD-LOS) #true)
(check-expect (contains-basic? BAD-LOS) #false)
(define (contains-basic? l)
  (contains? "basic" l))

(check-expect (contains-zoo? GOOD-LOS) #true)
(check-expect (contains-zoo? BAD-LOS) #false)
(define (contains-zoo? l)
  (contains? "zoo" l))