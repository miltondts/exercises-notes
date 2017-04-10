;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 145-non-empty_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 145

(define ERROR-MSG "Cannot handle empty lists")

; a NEList-of-temperatures is one of:
; - (cons CTemperature '())
; - (cons CTemperature NEList-of-temperatures)
; interpretation: non-empty list in Celsius

; A CTemperature is a Number greater than -273

; NEList-of-temperatures -> Boolean
; checks if the temperatures are organized in descending order
(define (sorted>? nelot)
  (cond
    [(empty? nelot) (error ERROR-MSG)]
    [(empty? (rest nelot)) #true]
    [else (and (> (first nelot) (first (rest nelot))) (sorted>? (rest nelot)))]))

(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(check-expect (sorted>? (cons 3 (cons 2 '()))) #true)
(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) #false)
(check-error (sorted>? '()) ERROR-MSG)


