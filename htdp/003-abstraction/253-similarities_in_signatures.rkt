;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 253-similarities_in_signatures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 253

; [Number -> Boolean]
; [X Y] X -> Y
(define (n2b n)
  #true)

; [Boolean String -> Boolean]
; [X Y] X Y -> X
(define (bs2b b s)
  #true)

; [Number Number Number -> Number]
; X X X -> X
(define (n3 a b c)
  (+ a b c))

; [Number -> [List-of Number]]
; X -> [X]
(define (n2ln n)
  (list n))

; [[List-of Number] -> Boolean]
; [X Y] [X] -> Y
(define (ln2b ln)
  #false)