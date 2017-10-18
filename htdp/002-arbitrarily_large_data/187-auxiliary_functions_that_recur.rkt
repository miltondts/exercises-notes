;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 187-auxiliary_functions_that_recur) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 187

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points 

(define PLAYER-1 (make-gp "Scorpion" 234))
(define PLAYER-2 (make-gp "Jade" 111))

(check-expect (sort> (list PLAYER-1 PLAYER-2)) (list PLAYER-1 PLAYER-2))
(check-expect (sort> (list PLAYER-2 PLAYER-1)) (list PLAYER-1 PLAYER-2))

; List-of-players-> List-of-players
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; GamePlayer List-of-players -> List-of-players
; inserts n into the sorted list of players l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= (gp-score n) (gp-score (first l)))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

