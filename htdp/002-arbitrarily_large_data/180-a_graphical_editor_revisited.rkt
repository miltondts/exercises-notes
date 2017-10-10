;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 180-a_graphical_editor_revisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 180

(require 2htdp/image)

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))

; Lo1s -> String
; concatenates 1Strings into a string
(define (cat s)
  (cond
    [(empty? s) ""]
    [else
     (string-append (first s) (cat (rest s)))]))

; Lo1s -> Image
; renders a list of 1Strings as a text image 
(define (editor-text s)
  (text (cat s) FONT-SIZE FONT-COLOR))

(check-expect
 (editor-text-2
  (cons "p" (cons "o" (cons "s" (cons "t" '())))))
 (text "post" FONT-SIZE FONT-COLOR))

; Lo1s -> Image
; renders a list of 1Strings as a text image 
(define (editor-text-2 s)
  (cond
    [(empty? s) ""]
    [else (beside (text (first s) FONT-SIZE FONT-COLOR) (editor-text (rest s)))]))



