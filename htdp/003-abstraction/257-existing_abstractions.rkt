;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 257-existing_abstractions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 257

; [X Y] [X Y -> Y] Y [List-of X] -> Y
; f*oldl works just like foldl
(check-expect (f*oldl cons '() '(a b c))
              (foldl cons '() '(a b c)))
(check-expect (f*oldl / 1 '(6 3 2))
              (foldl / 1 '(6 3 2)))
(define (f*oldl f e l)
  (foldr f e (reverse l)))


; [X] Number [Number -> X] Number -> [List-of X]
; constructs a list by applying f to 0, 1, ..., n - 1
(define (add-at-end n f tmp)
  (cond
   [(= tmp n) '()]
   [else
    (cons (f tmp) (add-at-end n f (add1 tmp)))]))

; [X] Number [Number -> X] -> [List-of X]
; build-l*st works just like build-list
; constructs a list by applying f to 0, 1, ..., n - 1
(check-expect (build-l*st 3 add1) (build-list 3 add1))
(check-expect (build-l*st 5 sub1) (build-list 5 sub1))
(define (build-l*st n f)
  (add-at-end n f 0))