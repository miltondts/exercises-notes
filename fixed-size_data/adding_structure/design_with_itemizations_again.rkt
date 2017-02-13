;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname design_with_itemizations_again) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Designing with Itemizations, Again
; Exercise 94
(require (lib "2htdp/image"))

(define CANVAS-WIDTH 180s)
(define CANVAS-HEIGHT 320)
(define TANK-WIDTH (/ CANVAS-WIDTH 10))
(define TANK-HEIGHT (/ CANVAS-HEIGHT 10))
(define UFO-DIAMETER (/ CANVAS-WIDTH 10))
(define CANVAS-COLOR "blue")
(define TANK-COLOR "green")
(define UFO-COLOR "green")
(define BCKGRND (empty-scene CANVAS-WIDTH CANVAS-HEIGHT CANVAS-COLOR))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" TANK-COLOR))
(define UFO (circle UFO-DIAMETER "solid" UFO-COLOR))

(place-image UFO (/ CANVAS-WIDTH 2) UFO-DIAMETER
             (place-image TANK (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT (/ TANK-HEIGHT 2)) BCKGRND))

; ------------------------------------------------------------------------------
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, CANVAS-HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game (Space Invader Game State)

; Example of stucture instances:
;(make-aim (make-posn 20 10) (make-tank 28 -3))

;(make-fired (make-posn 20 10)
;            (make-tank 28 -3)
;            (make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT)))

;(make-fired (make-posn 20 100)
;            (make-tank 100 3)
;            (make-posn 22 103))

;Exercise 95. Explain why the three instances are generated according to the
;             first or second clause of the data definition.
; The first and second clause are the data definitions of the UFO and of the
; TANK. Both these elements are present in the CANVAS throught the lifecyle
; of the Universe.
; Only when the UFO would explode, would it leave the CANVAS. But, in this case,
; the game would end.

; ------------------------------------------------------------------------------
; Exercise 96 - The sketches will be in the notebook


