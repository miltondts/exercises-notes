;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 143-non-empty_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A List-of-temperatures is one of:
; - '()
; - (cons CTemperature List-of-temperatures)

; A temperature is a number greater than -273

(define ERROR-MSG "Cannot apply empty list to average()")

(check-expect
 (average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-expect
 (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect
 (how-many (cons 1 (cons 2 (cons 3 '())))) 3)

; List-of-temperatures -> Number
; computes the average temperature
(define (average alot)
  (/ (sum alot) (how-many alot)))

; List-of-temperature -> Number
; adds up the temperature of a given list
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [(and (number? (first alot)) (> (first alot) -273))
     (+ (first alot) (sum (rest alot)))]
    [else (error "Invalid temperature in the list")]))

; List-of-temperature -> Number
; counts the temperatures on a given list
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ 1 (how-many (rest alot)))]))

; List-of-temperature -> Number
; returns an error if the list is empty
(define (checked-average alot)
  (cond
    [(empty? alot) (error ERROR-MSG)]
    [else (/ (sum alot) (how-many alot))]))

; Exercise 143
; (average '()) => /: division by zero
(check-error (checked-average '()) ERROR-MSG)