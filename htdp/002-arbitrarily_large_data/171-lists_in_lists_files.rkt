;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 169-lists_in_lists_files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 171
(require 2htdp/batch-io)

; A List-of-strings (LoS) is one of:
;     '()
;     (cons String LoS)
; intepretation: LoS is a list of strings

(define FILE (read-file "ttt.txt"))
(define WORDS (read-words "ttt.txt"))

; A List-of-List-of-strings (LoLoS) is one of:
;     '()
;     (cons LoS LoLoS)
; intepretation: LoLoS is a list of list of strings

(define WORDS-LINE (read-words/line "ttt.txt"))