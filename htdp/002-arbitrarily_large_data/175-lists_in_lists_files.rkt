;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 175-lists_in_lists_files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 175

(define CHAR-1 "r")
(define LINE-1 (cons "Don't"
                     (cons "panic" '())))
(define LINE-2 (cons "Bring"
                     (cons "a"
                           (cons "towel" '()))))
(define TEXT-1 (cons LINE-1 (cons LINE-2 '())))


(check-expect (count-chars-los '()) 0)
(check-expect (count-chars-los LINE-1) 10)
(check-expect (count-chars-los LINE-2) 11)

; LoS -> Number
; Count the number of 1Strings in a List-of-strings
(define (count-chars-los los)
  (cond
    [(empty? los) 0]
    [else
     (+ (string-length (first los)) (count-chars-los (rest los)))]))

(check-expect (count-chars TEXT-1) 21)

; File -> Number
; Count the number of 1Stringss in a file
(define (count-chars file)
  (if (empty? file)
      0
      (+ (count-chars-los (first file)) (count-chars (rest file)))))

; LoS -> Number
; Count the number of words in a List-of-strings
(define (count-words-los los)
  (cond
    [(empty? los) 0]
    [(string=? " " (first los)) (count-words-los (rest los))]
    [else
     (+ 1 (count-words-los (rest los)))]))

(check-expect (count-words TEXT-1) 5)

; File -> Number
; Count the number of words in a file
(define (count-words file)
  (if (empty? file)
      0
      (+ (count-words-los (first file)) (count-words (rest file)))))

(check-expect (count-lines '()) 0)
(check-expect (count-lines TEXT-1) 2)

; File -> Number
; Count the number of lines in a file
(define (count-lines file)
  (if (empty? file)
      0
      (+ 1 (count-lines (rest file)))))

(define-struct wcount [lines words chars])
; wcount is a structure
;     (make-wcount Number Number Number)

(check-expect (wc TEXT-1) (make-wcount 2 5 21))

; File -> Wcount
; Count the number of 1Strings, words, and lines in a given file
(define (wc file)
  (make-wcount (count-lines file) (count-words file) (count-chars file)))