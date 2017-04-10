;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 139-finger-exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 139

; 1) Define the data
(define ERROR-MSG "not a list of positive numbers")

; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of amounts)

; A List-of-numbers is one of
; - '()
; - (cons Number List-of-numbers)

; 2) Write down the function signature, header and purpose statement
; List-of-numbers -> Boolean
; determine whether all numbers in a list are positive
; (define (pos? ...))

; List-of-numbers -> Number
; computes the sum of the numbers if they belong to list-of-amounts
; (define (checked-sum ...))

; 3) Give examples
(define ex1 (cons 2
                  (cons 5
                        (cons 9 '()))))
(define ex2  (cons 1234 (cons 999 '())))
(define ex3  (cons 9000 '()))
(define ex4  (cons -9 '()))

; 4) Write the template
;(define (pos? l)
;  (cond
;    [(empty? l) ...]
;    [else (... (first l) ... (pos? (rest l)) ...)]))

;(define (checked-sum l)
;  (cond
;    [(empty? l) ...]
;    [else (... (first l) ... (checked-sum (rest l)) ...)]))

; 5) Write the function
(define (pos? l)
  (cond
    [(empty? l) #true]
    [else (and (positive? (first l)) (pos? (rest l)))]))

(define (checked-amount l)
  (if (pos? l)
      (cond
        [(empty? l) 0]
        [else (+ (first l) (checked-amount (rest l)))])
     (error ERROR-MSG)))

; 6) Write the tests
(check-expect (pos? ex1) #true)
(check-expect (pos? ex2) #true)
(check-expect (pos? ex3) #true)
(check-expect (pos? ex4) #false)

(check-expect (checked-amount ex1) 16)
(check-expect (checked-amount ex2) 2233)
(check-expect (checked-amount ex3) 9000)
(check-error (checked-amount ex4) ERROR-MSG)

; The way I designed it, sum computes the sum of the amounts only if the
; number is positive, otherwise it signalled an error.
; The way the guys from HTDP thought I would design the function, sum would let
; all numbers pass. Not taking into account whether they're positive or not.