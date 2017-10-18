;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 186-auxiliary_functions_that_recur) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 186

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

(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))

(check-satisfied (sort>/bad (list 2 5 9)) sorted>?)
(check-expect (sort>/bad (list 2 5 9)) (list 9 5 2))

; I cannot formulate a test case that show that sort>/bad is not a sorting function
; with check-satisfied. I can, however, do so with check-expect.
; Given the output of sort>/bad will always be a list of numbers in descendent order
; check-satisfied is always, wait for it, satisfied

