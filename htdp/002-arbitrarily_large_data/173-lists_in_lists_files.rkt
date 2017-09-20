;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 173-lists_in_lists_files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Exercise 173
(require 2htdp/batch-io)

(check-expect (is-art? "a") #true)
(check-expect (is-art? "an") #true)
(check-expect (is-art? "the") #true)
(check-expect (is-art? "you") #false)

; Check if the string is an article
; String -> Bool
(define (is-art? str)
  (cond
    [(string=? str "a") #true]
    [(string=? str "an") #true]
    [(string=? str "the") #true]
    [else #false]))

(define STR-EX1 (cons "Am" (cons "I" (cons "a" (cons "indian" '())))))
(define STR-EX2 (cons "Carachi" (cons "na" '())))

(check-expect (remove-art-los '()) '())
(check-expect (remove-art-los STR-EX1) (cons "Am" (cons "I" (cons "indian" '()))))
(check-expect (remove-art-los STR-EX2) STR-EX2)
; Remove articles from string
; LoS -> LoS
(define (remove-art-los los)
  (cond
    [(empty? los) '()]
    [(is-art? (first los)) (remove-art-los (rest los))]
    [else
     (cons (first los) (remove-art-los (rest los)))]))

(check-expect (remove-art-lls '()) '())
(check-expect (remove-art-lls (cons STR-EX1 (cons STR-EX2 '()))) (cons (cons "Am" (cons "I" (cons "indian" '()))) (cons (cons "Carachi" (cons "na" '())) '())))
; Remove articles from text
; LLS -> LLS
(define (remove-art-lls lls)
  (if (empty? lls)
      '()
      (cons (remove-art-los (first lls)) (remove-art-lls (rest lls)))))

; Convert a list of strings into a line
; LoS -> String
(define (los-to-line los)
  (if (empty? los)
      "\n"
      (string-append (first los) " " (los-to-line (rest los)))))

; Converts a list of lines into a string
; List-of-strings -> String
(define (collapse lls)
  (if (empty? lls)
      ""
      (string-append (los-to-line (first lls)) (collapse (rest lls)))))

; Removes all articles from a text file
; File -> File
(define (no-articles n)
  (write-file (string-append "no-articles-" n)
              (collapse (remove-art-lls (read-words/line n)))))

(no-articles "ttt.txt")


