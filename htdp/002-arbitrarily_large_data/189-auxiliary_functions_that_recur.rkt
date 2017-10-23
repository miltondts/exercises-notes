;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 189-auxiliary_functions_that_recur) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 189

(define ERROR-MSG "Cannot handle empty lists")

(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(check-expect (sorted>? (cons 3 (cons 2 '()))) #true)
(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) #false)
(check-error (sorted>? '()) ERROR-MSG)

; NEList-of-temperatures -> Boolean
; checks if the temperatures are organized in descending order
(define (sorted>? nelot)
  (cond
    [(empty? nelot) (error ERROR-MSG)]
    [(empty? (rest nelot)) #true]
    [else (and (> (first nelot) (first (rest nelot))) (sorted>? (rest nelot)))]))

(check-satisfied (sort> (list 2 5 9)) sorted>?)
(check-satisfied (sort> (list 9 4 2)) sorted>?)

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))

(check-expect (search-sorted 5 (list 2 5 9)) #true)
(check-expect (search-sorted 8 (list 2 5 9)) #false)

; Number List-of-numbers -> Boolean
; determines whether a number occurs in a sorted list of numbers.
(define (search-sorted n alon)
  (search n (sort> alon)))