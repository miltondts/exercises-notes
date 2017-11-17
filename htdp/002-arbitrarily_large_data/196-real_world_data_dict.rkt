;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 196-real_world_data_dict) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 196

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

(define-struct letter-counts [letter count])
; Letter-Counts is a structure:
; (make-letter-counts 1String Number)

; A list List-of-Letter-Counts is one of:
; - '()
; - (cons letter-counts LoLC)

; A list List-of-Letters is one of:
; - '()
; - (cons 1String LoL)

; Dictionary LoL LoLC-> LoLC
(define (count-by-letter dict lol lolc)
  (cond
    [(empty? lol) lolc]
    [else
     (count-by-letter dict (rest lol) (cons (starts-with# (first lol) dict) lolc))]))


(check-expect (starts-with# "e" (list "every" "ear" "eats" "spiders"))
              (make-letter-counts "e" 3))
(check-expect (starts-with# "m" (list "let" "mix" "this" "multiply"))
              (make-letter-counts "m" 2))
(check-expect (starts-with# "a" (list "an" "abnormal" "Antilope" "died"))
              (make-letter-counts "a" 2))
; Letter Dictionary -> Letter-Counts
; Counts the number of words in a Dictionary that start with Letter
(define (starts-with# letter dict)
  (make-letter-counts letter (starts-with letter dict 0)))

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


(count-by-letter DICTIONARY-AS-LIST LETTERS '())