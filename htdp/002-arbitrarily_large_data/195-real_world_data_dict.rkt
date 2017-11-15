;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 195-real_world_data_dict) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 195
(require 2htdp/batch-io)

(define DICTIONARY-LOCATION "/usr/share/dict/words")
 
; A Dictionary is a List-of-strings.
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(check-expect (starts-with# "e" (list "every" "ear" "eats" "spiders")) 3)
(check-expect (starts-with# "m" (list "let" "mix" "this" "multiply")) 2)
(check-expect (starts-with# "a" (list "an" "abnormal" "Antilope" "died")) 2)
; Letter Dictionary -> Number
; Counts the number of words in a Dictionary that start with Letter
(define (starts-with# letter dict)
  (starts-with letter dict 0))

(check-expect (starts-with "e" (list "every" "ear" "eats" "spiders") 0) 3)
(check-expect (starts-with "m" (list "let" "mix" "this" "multiply") 0) 2)
(check-expect (starts-with "a" (list "an" "abnormal" "Antilope" "died") 0) 2)
; Letter Dictionary Number -> Number
; Counts the number of words in a Dictionary that start with Letter
(define (starts-with letter dict n)
  (cond
    [(empty? dict) n]
    [(starts-with? letter (first dict))
     (starts-with letter (rest dict) (+ n 1))]
    [else
     (starts-with letter (rest dict) n)]))

(check-expect (starts-with? "b" "banana") #true)
(check-expect (starts-with? "B" "banana") #false)
(check-expect (starts-with? "A" "Aardvark") #false)
(check-expect (starts-with? "c" "guriguri") #false)
; Letter String -> Bool
; Checks if a String starts with a given Letter
(define (starts-with? letter word)
  (if
   (is-letter? letter)
   (string=?
    letter
    (first (explode word)))
   #false))

(check-expect (is-letter? "y") #true)
(check-expect (is-letter? "Y") #false)
; 1String -> Bool
; Checks if 1String is a part of LETTERS
(define (is-letter? letter)
  (member? letter LETTERS))

(starts-with# "e" DICTIONARY-AS-LIST)
(starts-with# "z" DICTIONARY-AS-LIST)