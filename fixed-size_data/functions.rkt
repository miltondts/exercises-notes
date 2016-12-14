;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 11
(define (f x y) (sqrt (+ (sqr x) (sqr y))))
(f 5 5) ;test

;exercise 12
(define (cvolume l) (* l l l ))
(cvolume 3) ;test

(define (csurface l) (sqr l))
(csurface 3) ;test

;exercise 13
(define (string-first s)
  (if (string? s) (if (> (string-length s) 0) (string-ith s 0) "blah") "not a string" ))

(string-first "")          ;test
(string-first 1)           ;test
(string-first "Delicious") ;test (it gives you the D)