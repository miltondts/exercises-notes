;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 162-functions_that_produce_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 162

(define WAGE 14)
(define HOUR-LIMIT 100)
(define FRAUD-ALERT "No employee could possibly work more than 100 hours per week")

(define ex1 '())
(define ex2 (cons 28 '()))
(define ex3 (cons 4 (cons 2 '())))
(define ex4 (cons 365 (cons 2 '())))

(check-expect (wages* ex1) ex1)
(check-expect (wages* ex2) (cons (* 28 WAGE) '()))
(check-expect (wages* ex3) (cons (* 4 WAGE) (cons (* 2 WAGE) '())))
(check-error (wages* ex4) FRAUD-ALERT)
; List-of-wages -> List-of-wages
; computes the weekly wages for the weekly hours
(define (wages* whrs)
  (cond
    [(empty? whrs) '()]
    [else
     (cons (wage (first whrs)) (wages* (rest whrs)))]))

(check-error (wage 200) FRAUD-ALERT)
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (if (fraud? h)
      (error FRAUD-ALERT)
      (* WAGE h)))

(check-expect (fraud? 200) #t)
(check-expect (fraud? 100) #f)
(check-expect (fraud? 40) #f)
; Number -> Bool
; check the number is under the legal limit
(define (fraud? hrs)
  (if (> hrs 100)
      #t
      #f))
  