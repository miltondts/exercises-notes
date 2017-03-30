;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 154-russian_dolls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct layer [color doll])
; A RD (short for Russian Doll) is one of:
; - String
; - (make-layer String RD)

; RD -> Number
; how many dolls are part of an-rd
(define (depth an-rd)
  (cond
   [(string? an-rd) 1]
   [else
    (+ 1 (depth (layer-doll an-rd)))]))

(check-expect (depth "red") 1)
(check-expect (depth (make-layer "yellow" (make-layer "green" "red"))) 3)

; Exercise 154

(check-expect (colors "white") "white")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")

; RD -> String
; produces a string of all colors, separated by a comma and a space
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else
     (string-append (layer-color an-rd) ", " (colors (layer-doll an-rd)))]))