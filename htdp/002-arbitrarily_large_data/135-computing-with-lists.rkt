;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 135-computing-with-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 135
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) "Flatt") #true]
       [else (contains-flatt? (rest alon))])]))

(contains-flatt? (cons "Flatt" (cons "C" '())))
(contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))

; If "Flatt" is replace by B, both function calls will return #false and the
; expressions will be verified all the way until C is evaluated
(contains-flatt? (cons "A" (cons "B" (cons "C" '()))))


   

