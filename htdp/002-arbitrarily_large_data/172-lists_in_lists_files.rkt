;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 172-lists_in_lists_files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 172
(require 2htdp/batch-io)

(define STRING-EX1 (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '()))))))
(define LINE-EX1 (cons "I'm Blue" (cons "Abadi" '())))
(define LINE-EX2 (cons "Abada" '()))
(define LLS-EX1 (cons LINE-EX1 (cons LINE-EX2 '())))

; A List-of-strings (LoS) is one of:
;     '()
;     (cons String LoS)
; intepretation: LoS is a list of strings

(check-expect (los-to-line '()) "\n")
(check-expect (los-to-line STRING-EX1) "Put up in a place \n")

; Convert a list of strings into a line
; LoS -> String
(define (los-to-line los)
  (if (empty? los)
      "\n"
      (string-append (first los) " " (los-to-line (rest los)))))

(check-expect (collapse '()) "")
(check-expect (collapse LLS-EX1) "I'm Blue Abadi \nAbada \n")

; Converts a list of lines into a string
; List-of-strings -> String
(define (collapse lls)
  (if (empty? lls)
      ""
      (string-append (los-to-line (first lls)) (collapse (rest lls)))))

(write-file "ttt.dat"
            (collapse (read-words/line "ttt.txt")))

