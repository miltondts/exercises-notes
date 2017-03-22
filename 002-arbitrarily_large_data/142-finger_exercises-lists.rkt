;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 142-finger_exercises-lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 142

(require (lib "2htdp/image"))

(define BLACK-SQUARE (square 20 "solid" "black"))
(define BLACK-RECTANGLE (rectangle 50 20 "solid" "black"))
(define GREEN-SQUARE (square 20 "solid" "green"))
(define YELLOW-SQUARE (square 20 "outline" "yellow"))

(check-expect (ill-sized? '() 20) #false)
(check-expect (ill-sized? (cons GREEN-SQUARE (cons YELLOW-SQUARE '())) 20) #false)
(check-expect (ill-sized? (cons BLACK-RECTANGLE (cons BLACK-SQUARE '())) 20) BLACK-RECTANGLE)

; ImageOrFlase is on of:
; - Image
; - #false

; List-of-images PositiveNumber -> ImageOrFalse
; produces the first image of loi that is not an n by n square
; or false if it cannot find such image
(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(and
      (= (image-width (first loi)) n)
      (= (image-height (first loi)) n))
     (ill-sized? (rest loi) n)]
    [else
     (first loi)]))


