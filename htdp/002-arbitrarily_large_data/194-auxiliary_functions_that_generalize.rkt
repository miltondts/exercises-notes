;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 194-auxiliary_functions_that_generalize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 194

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

(check-expect (render-poly MT triangle-p)
              (scene+line 
               (scene+line
                (scene+line MT 20 10 20 20 "red")
                20 20 30 20 "red")
               30 20 20 10 "red"))

; Image Polygon -> Image 
; adds an image of p to MT
(define (render-poly img p)
  (connect-dots img p (first p)))
 
; Image NELoP Posn -> Image
; connects the Posns in p in an image
(define (connect-dots img p last)
  (cond
    [(empty? (rest p)) (render-line MT (first p) last)]
    [else (render-line (connect-dots img (rest p) last)
                       (first p)
                       (second p))]))
 
; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
 