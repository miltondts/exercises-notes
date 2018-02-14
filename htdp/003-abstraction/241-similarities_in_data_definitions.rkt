;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 241-similarities_in_data_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 241

; A NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

; a NEList-of-booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-booleans)
; interpretation non-empty list of boolean

; A [NEList-of ITEM] is one of: 
; – (cons ITEM '())
; – (cons ITEM [NEList-of ITEM])