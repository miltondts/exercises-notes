;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 191-auxiliary_functions_that_generalize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 191

(require 2htdp/image)

; a plain background image 
(define MT (empty-scene 50 50))
(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))
	
(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))

; Image Posn Posn -> Image 
; renders a line from p to q into img
(define (render-line img p q)
  (scene+line
    img
    (posn-x p) (posn-y p) (posn-x q) (posn-y q)
    "red"))

; A NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else
     (render-line
       (connect-dots img (rest p))
       (first p)
       (second p))]))

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img


(check-expect (connect-dots MT triangle-p)
              (scene+line
               (scene+line MT 20 10 20 20 "red")
               20 20 30 20 "red"))

(check-expect (connect-dots MT square-p)
               (scene+line
                (scene+line
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red"))


