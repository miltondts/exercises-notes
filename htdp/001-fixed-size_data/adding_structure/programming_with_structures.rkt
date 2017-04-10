;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname programming_with_structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 72
(define-struct phone [area number])
; A Phone is a structure
;    (make-phone Number String)
; interpretation: (make-phone area number) means a three digits that make up
; the area code and the 7 digits that comprise the phone number (with an
; hifen between them)

(define-struct phone# [area switch num])
; A Phone# is a structure
;    (make-phone# Number Number Number)
; interpretation: (make-phone# area switch number) means a phone number with
; area being a number inside [0 : 999]
; switch being a number inside [0 : 999]
; num being a number inside [0 : 9999]


; ------------------------------------------------------------------------------
; Exercise 73
; Posn Number -> Posn
; produces a Posn with n in the x field.
(check-expect (posn-up-x (make-posn 0 12) 4) (make-posn 4 12))
(check-expect (posn-up-x (make-posn 4 12) 6) (make-posn 6 12))
(define (posn-up-x p n) (make-posn n (posn-y p)))

; Note: functions like posn-up-x are called updaters or functional setters and
; are very useful in large programs

; ------------------------------------------------------------------------------
; Stop! Interpret the two examples.
;(check-expect
;  (reset-dot (make-posn 10 20) 29 31 "button-down")
;  (make-posn 29 31))
;
; When the mouse button is pressed (button-down) the dot will be placed where
; the mouse click occured

;(check-expect
;  (reset-dot (make-posn 10 20) 29 31 "button-up")
;  (make-posn 10 20))
;
; "button-up" signals that the user released the mouse button and the dot will
; continue moving as it was

; ------------------------------------------------------------------------------
; Exercise 74
(require 2htdp/image)
(require 2htdp/universe)

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))
 
; A Posn represents the state of the world.
 
; Posn -> Posn 
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [on-mouse reset-dot]
    [to-draw scene+dot]))


(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
; Posn -> Image
; adds a red spot to MTS at p
(define (scene+dot p)
  (place-image DOT (posn-x p) (posn-y p) MTS))

(check-expect (x+ (make-posn 3 3)) (make-posn 6 3))
; Posn -> Posn
; increases the x-coordinate of p by 3
(define (x+ p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))


(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-down")
  (make-posn 29 31))
(check-expect
  (reset-dot (make-posn 10 20) 29 31 "button-up")
  (make-posn 10 20))
; Posn Number Number MouseEvt -> Posn 
; for mouse clicks, (make-posn x y); otherwise p
(define (reset-dot p x y me)
  (cond
    [(mouse=? me "button-down") (make-posn x y)]
    [else p]))

; ------------------------------------------------------------------------------
; Note: If a function deals with nested structures, develop one function per
; level of nesting.

; ------------------------------------------------------------------------------
; Exercise 75
(define-struct vel [deltax deltay])
; A Vel is a structure: 
;   (make-vel Number Number)
; interpretation (make-vel dx dy) means a velocity of 
; dx pixels [per tick] along the horizontal and
; dy pixels [per tick] along the vertical directions

(define-struct ufo [loc vel])
; A UFO is a structure: 
;   (make-ufo Posn Vel)
; interpretation (make-ufo p v) is at location
; p moving at velocity v.

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))
 
(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))
 
(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))
 
(check-expect (ufo-move-1 u1) u3) ; x = 22 + 8; y = 80 - 3
(check-expect (ufo-move-1 u2) ; x = 22 - 5 ; y = 80 - 3
              (make-ufo (make-posn 17 77) v2))
; UFO -> UFO
; determines where u moves in one clock tick; 
; leaves the velocity as iss
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
; Posn Vel -> Posn 
; adds v to p 
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))



