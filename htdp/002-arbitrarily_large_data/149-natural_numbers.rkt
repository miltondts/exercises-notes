;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 149-natural_numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 149
; copier works fine as long as n is a natural positive number,
; there is no need to design another function
; (copier 0.1 "x") => Given it doesn't have any else condition. It exits
;because no condition is true.
; (copier.v2 0.1 "x") =>  Because the result never equals 0, the function
; keeps trying to evaluate the result until it reaches the maximum memory limit

; N String -> List-of-strings
; create a list with n copies of s

(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello") (cons "hello" (cons "hello" '())))
(check-expect (copier 0 #true) '())
(check-expect (copier 2 #true) (cons #true (cons #true '())))

(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

(check-expect (copier.v2 0 "hello") '())
(check-expect (copier.v2 2 "hello") (cons "hello" (cons "hello" '())))
(check-expect (copier.v2 0 #true) '())
(check-expect (copier.v2 2 #true) (cons #true (cons #true '())))
(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))