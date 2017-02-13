;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname design_with_itemizations_again) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Designing with Itemizations, Again
; Exercise 94
(require (lib "2htdp/image"))

(define CANVAS-WIDTH 180)
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
                         