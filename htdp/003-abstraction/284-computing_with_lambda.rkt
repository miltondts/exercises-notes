;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 284-computing_with_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 284

((lambda (x) x) (lambda (x) x))

((lambda (x) (x x)) (lambda (x) x))

((lambda (x) (x x)) (lambda (x) (x x)))