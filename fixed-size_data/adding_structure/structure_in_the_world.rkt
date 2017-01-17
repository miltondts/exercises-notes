;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname structure_in_the_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Structure in the World, aka Space Invaders rip-off

; In a first instance, a SpaceGame is a structure of type:
;     (make-space-game Number Number)
; Interpretation (make-space-game y x) descibes the UFO at y-coordinate y and
; the Tank at x-coordinate x
(define-struct space-game [ufo tank])