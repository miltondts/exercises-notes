;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 138-finger_exercises-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 138

(define ERROR-MSG "not a positive number")

; 1) Define the data
; A List-of-amounts is one of:
; - '()
; - (cons PositiveNumber List-of amounts)


; 2) Purpose statement, function signature and header
; List-of-amounts -> Number
; computes the sum of the amounts
; (define (sum l) ...)

; 3) Build functional examples
(define ex1 (cons 2
                  (cons 5
                        (cons 9 '()))))
(define ex2  (cons 1234 (cons 999 '())))
(define ex3  (cons 9000 '()))

; 4) Build a template
; List-of-amounts -> Number
; computes the sum of the amounts
; (define (sum l)
;   (cond
;     [(empty? l) ...]
;     [else (... (first l) ... (sum (rest l)) ...)]))

; 5) Build the function
(define (sum l)
   (cond
     [(empty? l) 0]
     [(positive? (first l))
      (+ (first l) (sum (rest l)))]
     [else (error ERROR-MSG)]))

; 6) Turn the examples into tests
(check-expect (sum ex1) 16)
(check-expect (sum ex2) 2233)
(check-expect (sum ex3) 9000)
(define ex4  (cons -9 '()))
(check-error (sum ex4) ERROR-MSG)
