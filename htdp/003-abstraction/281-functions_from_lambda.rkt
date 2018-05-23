;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 281-functions_from_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 281

(require (lib "2htdp/image"))

; --- CONSTANTS ---
(define THRESHOLD 10)
(define RED-DOT (circle 5 "solid" "red"))
(define SQUARE (square 10  "outline" "black"))
(define EMPTY-SCENE (empty-scene 50 50))

; --- DATA DEFINITIONS ---
(define-struct ir [name price])
; An IR is a structure:
;   (make-ir String Number)

; --- LAMBDA FUNCTIONS ---
(check-expect (LAMBDA1 5) #true)
(check-expect (LAMBDA1 10) #false)
(check-expect (LAMBDA1 15) #false) 
; consumes a number and decides whether it is less than 10
(define LAMBDA1 (lambda (x) (< x THRESHOLD)))

(check-expect (LAMBDA2 1 2) "2")
(check-expect (LAMBDA2 5 5) "25")
; multiplies two given numbers and turns the result into a string
(define LAMBDA2
  (lambda (x y) (number->string (* x y))))

(check-expect (LAMBDA3 2) 0)
(check-expect (LAMBDA3 3) 1)
; consumes a natural number and returns 0 it is even and 1 if odd
(define LAMBDA3
  (lambda (x)
    (if (= 0 (remainder x 2))
        0
        1)))

(check-expect (LAMBDA4 (make-ir "Record 1" 1) (make-ir "Record 2" 2)) #true)
; consumes two inventory records and compares them by price
(define LAMBDA4
  (lambda (ir1 ir2) (<= (ir-price ir1) (ir-price ir2))))


(check-expect (LAMBDA5 (make-posn 25 25) EMPTY-SCENE)
              (place-image RED-DOT 25 25 EMPTY-SCENE))
; adds a red dot at a given Posn to a given Image
(define LAMBDA5
  (lambda (position image) (place-image RED-DOT (posn-x position) (posn-y position) image)))