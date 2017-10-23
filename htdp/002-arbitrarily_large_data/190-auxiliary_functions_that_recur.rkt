;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 190-auxiliary_functions_that_recur) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 190

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "a" "b") (list "a")))

; List-of-1Strings -> List-of-prefixes
; produces the list of all prefixes
(define (prefixes lo1s)
  (cond
    [(empty? lo1s) '()]
    [else (cons lo1s (prefixes (remove-last lo1s)))]))

(check-expect (remove-last '()) '())
(check-expect (remove-last (list "a" "b")) (list "a"))

; List-of-1Strings -> List-of-1Strings
; Removes the last element prior to '()
(define (remove-last lo1s)
  (cond
    [(empty? lo1s) '()]
    [(empty? (rest lo1s)) '()]
    [else
     (cons (first lo1s) (remove-last (rest lo1s)))]))

(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "b" "c") (list "c")))
; List-of-1Strings -> List-of-suffixes
; produces the list of all suffixes
(define (suffixes lo1s)
  (cond
    [(empty? lo1s) '()]
    [else (cons lo1s (suffixes (rest lo1s)))]))