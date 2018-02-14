;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 239-similarities_in_data_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 239

; A [List X Y] is a structure: 
;   (cons X (cons Y '()))

; A [List Number Number] is a structure:
; – (cons Number (cons Number '())
; (cons 3 (cons 4 '())

; A [List Number 1String] is a structure:
; – (cons Number (cons String '())
; (cons 3 (cons "bliat" '())

; A [List Number Number] is a structure:
; – (cons String (cons Boolean '())
; (cons "here" (cons #true '())