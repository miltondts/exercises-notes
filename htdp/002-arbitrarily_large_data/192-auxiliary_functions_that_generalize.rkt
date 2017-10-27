;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 192-auxiliary_functions_that_generalize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 192

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

; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else
     (render-line
       (connect-dots img (rest p))
       (first p)
       (second p))]))

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

; Argue why it is acceptable to use last on Polygons.
;-> Because all polygons will have a final dot before the '(). Besides, we want to connect the final dot with the first to close the polygon.

;Also argue why you may adapt the template for connect-dots to last
;-> Because we need to transverse the whole list of dots to reach the last one. The template for a non-empty list is always the same.

(check-expect (last triangle-p) (make-posn 30 20))
(check-expect (last square-p) (make-posn 10 20))

; NELoP -> Posn
; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest p)) (first p)]
    [else (last (rest p))]))

(check-expect (polygon-last triangle-p) (make-posn 30 20))
(check-expect (polygon-last square-p) (make-posn 10 20))
; Polygon -> Posn
; extracts the last item from p
(define (polygon-last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (polygon-last (rest p))]))


(check-expect (render-polygon MT triangle-p)
              (scene+line 
               (scene+line
                (scene+line MT 20 10 20 20 "red")
                20 20 30 20 "red")
               30 20 20 10 "red"))
              
; Image Polygon -> Image 
; adds an image of p to MT
(define (render-polygon img p)
  (render-line (connect-dots img p) (first p) (last p)))

(render-polygon MT triangle-p)



