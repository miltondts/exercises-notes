;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 164-functions_that_produce_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 164

(define EXCHANGE-RATE 1.12)

(check-expect (exchange 1 EXCHANGE-RATE) EXCHANGE-RATE)
; Number -> Number
; converts an amount cur of currency given the
; specified rate
(define (exchange cur rate)
  (* cur rate))

; A List-of-US$ is one of:
; - '()
; - (cons Number List-of-US$)

; A List-of-€ is one of:
; - '()
; - (cons Number List-of-€)

(define ex1 '())
(define ex2 (cons 1 '()))

(check-expect (convert-euro* ex1 EXCHANGE-RATE) '())
(check-expect (convert-euro* ex2 EXCHANGE-RATE) (cons (* 1 EXCHANGE-RATE)'()))
; List-of-US$ -> List-of-€
; converts a list of US$ into a list of € amounts
(define (convert-euro* lod rate)
  (if (empty? lod)
      '()
      (cons (exchange (first lod) rate) (convert-euro* (rest lod) rate))))