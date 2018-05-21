;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 275-projects_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 275

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

(check-expect (most-frequent (list "ear" "egad" "abelung")) (make-letter-counts "e" 2))
; Dictionary -> Letter-Counts
; Presents the letter that occurs most often as the first one
(define (most-frequent dict)
  (local
    (; Letter-Counts Letter-Counts -> Boolean
     ; Check if xlc has a greater count than xly
     (define (cmp-lc xlc ylc)
       (>= (letter-counts-count xlc) (letter-counts-count ylc))))
    (first (sort (count-by-letter dict LETTERS) cmp-lc))))

; Dictionary LoL -> LoLC
; Get a list of letter counts of the first letters of the words in dict
(define (count-by-letter dict lol)
  (local
    (; Letter Dictionary -> Letter-Counts
     ; Creates a letter-count for letter
     (define (starts-with# letter)
       (make-letter-counts letter (count-letter letter dict 0))))
    (map starts-with# lol)))

(check-expect (count-letter "e" (list "every" "ear" "eats" "spiders") 0) 3)
(check-expect (count-letter "m" (list "let" "mix" "this" "multiply") 0) 2)
(check-expect (count-letter "a" (list "an" "abnormal" "Antilope" "died") 0) 2)
; Letter Dictionary Number -> Number
; Counts the number of words in a Dictionary that start with a given letter
(define (count-letter letter dict n)
  (cond
    [(empty? dict) n]
    [(starts-with? letter (first dict))
     (count-letter letter (rest dict) (+ n 1))]
    [else
     (count-letter letter (rest dict) n)]))

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

(define (not-empty? list-of-something)
  (not (empty? list-of-something)))

(check-expect (words-by-first-letter '()) '())
(check-expect (words-by-first-letter  (list "whatsapp" "world"))
              (list (list "whatsapp" "world")))
(check-expect (words-by-first-letter (list "every" "ear" "eats" "spiders"))
              (list (list "every" "ear" "eats") (list "spiders")))
; Dictionary -> List-of-Dictionaries
; Produces a list of Dictionaries, one per Letter
(define (words-by-first-letter dict)
  (local
    (; Letter -> Dictionary
     ; Produces a Dictionary of all words that start with Letter
     (define (produce-dict letter)
      (local
        (; String -> Bool
        ; Checks if a word starts with a given Letter
        (define (starts-with-letter? word)
          (if
           (is-letter? letter)
           (string=?
            letter
            (first (explode word)))
           #false)))
         (filter starts-with-letter? dict))))
    (filter not-empty? (map produce-dict LETTERS))))