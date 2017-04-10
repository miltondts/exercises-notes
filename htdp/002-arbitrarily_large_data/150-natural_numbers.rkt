;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 150-natural_numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 150
; N -> Number
; computes (+ n pi) without using +

(check-within (add-to-pi 3) (+ 3 pi) 0.001)
; given pi is an inexact number, it is require to use a delta (i.e. 0.001)
; to guarantee that the number calculate is within an interval of size delta

(define (add-to-pi n)
  (* n (add1 (/ pi n))))

; Generalizing
; N X -> Number
; computes (+ n x) without using +

(check-expect (add-to-x 3 10) 13)

(define (add-to-x n x)
  (* n (add1 (/ x n))))