;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 137-finger_exercises-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 137
; Both templates have 2 cond clauses, one to handle the sub-class empty-list
; and another with natural recursion and the appropriate select expressions
; for list (i.e. rest and first).
; Basically, both fit with how to translate data definitions to templates
; (as definied in figure 48)


; List-of-strings -> Number
; determines how many strings are on alos
; (define (how-many alos)
;     (cond
;       [(empty? alos) ...]
;       [else
;         (... (first alos) ...
;          ... (how-many? (rest alos)) ...)]))


; List-of-names -> Boolean
; (define (contains-flat? alon)
;     (cond
;       [(empty? alon) ... ]
;       [else
;         (... (string=? alon) "Flatt")
;          ... (contains-flatt? (rest alon)) ...)]))
