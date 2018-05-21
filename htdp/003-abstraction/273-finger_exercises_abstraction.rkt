;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 273-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 273

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
; constructs a list by applying f to each item on lx
; (map f (list x-1 ... x-n)) == (list (f x-1) ... (f x-n))

; [X Y] [X Y -> Y] Y [List-of X] -> Y
; applies f from right to left to each item in lx and b
; (foldr f b (list x-1 ... x-n)) == (f x-1 ... (f x-n b))

(define TEST1 (list 1 2 3 4))

(check-expect (fold-map add1 '()) (map sqr '()))
(check-expect (fold-map sqr TEST1) (map sqr TEST1))
(check-expect (fold-map add1 TEST1) (map add1 TEST1))
; [X Y] [X -> Y] [List-of X] -> [List-of Y]
(define (fold-map f lox)
  (local
    (; X [List-of X] -> [List-of X]
     ; cons' application o f to elem onto acc
     (define (fmap elem acc)
      (cons (f elem) acc)))
    (foldr fmap '() lox)))
