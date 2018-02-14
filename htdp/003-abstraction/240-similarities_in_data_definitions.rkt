;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 240-similarities_in_data_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 240

(define-struct layer [stuff])

; A LStr is one of: 
; – String
; – (make-layer LStr)
; Examples of LStr:
; "blah"
; (make-layer "blah")
; (make-layer (make-layer "blah")
    
	
; A LNum is one of: 
; – Number
; – (make-layer LNum)
; Examples of LNum:
; 2
; (make-layer 3)
; (make-layer (make-layer 4)

; Abstract the previous definitions:
; A ITEM is one of: 
; – ITEM 
; – (make-layer ITEM)

; Instatiate the abstraction to get the original data:
;[String] => LStr
;[Number] => LNum