;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 174-lists_in_lists_files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 174

(require 2htdp/batch-io)

; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; convert the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))

; List-of-1String -> String
; Encodes each letter in a list of 1Strings

(check-expect (encode-lo1s '()) "")
(check-expect (encode-lo1s (cons "z" (cons "a" '()))) "122097")

(define (encode-lo1s lo1s)
  (if (empty? lo1s)
      ""
      (string-append (encode-letter (first lo1s)) (encode-lo1s (rest lo1s)))))

; String -> String
; Encodes each letter in a word

(check-expect (encode-word "az") "097122")

(define (encode-word word)
  (encode-lo1s (explode word)))

; LoS -> LoS

(define LOS-EX1 (cons "az" (cons "za" '())))
(define LOS-EX1-ENCODED (cons "097122" (cons "122097" '())))
(define LOS-EX2 (cons "az" '()))
(define LOS-EX2-ENCODED (cons "097122" '()))

(check-expect (encode-los LOS-EX1) LOS-EX1-ENCODED)

(define (encode-los los)
  (if (empty? los)
      '()
      (cons (encode-word (first los)) (encode-los (rest los)))))

; LLS -> LLS
; Encodes each list of strings in a  list of list of string

(define LLS-EX1 (cons LOS-EX1 (cons LOS-EX2 '())))
(check-expect (encode-lls LLS-EX1) (cons LOS-EX1-ENCODED (cons LOS-EX2-ENCODED '())))

(define (encode-lls lls)
  (if (empty? lls)
      '()
      (cons (encode-los (first lls)) (encode-lls (rest lls)))))

; File -> LLS
; Encodes each list of strings in a File

(define (encode-file file)
  (encode-lls (read-words/line file)))

(encode-file "ttt.txt")
     

