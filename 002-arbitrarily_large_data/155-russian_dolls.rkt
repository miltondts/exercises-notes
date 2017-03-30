;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 155-russian_dolls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct layer [color doll])
; A RD (short for Russian Doll) is one of:
; - String
; - (make-layer String RD)


(check-expect (inner "red") "red")
(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) "red")
; Exercise 155
; RD -> String
; returns the color of the innermost doll
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (inner (layer-doll an-rd))]))