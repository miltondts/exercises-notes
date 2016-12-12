;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 1
;distance formula
;encounter a point (x,y) as a distance d = (sqrt(x^2 + y^2))
    (define x 3) ;define the variable x as the number 3
    (define y 4) ;define the variable y as the number
    (sqrt (+ (sqr x) (sqr y))) ;compute the square root of the sum of the square of each variable

;exercise 2
; append two BSL strings
(define prefix "hello") ;define the variable prefix as a string with the sequence “hello"
(define suffix "world") ;define the variable suffix as a string with the sequence “world"
(string-append prefix “_” suffix) ;append the prefix variable with a “_” 1String and append those with the suffix string
  