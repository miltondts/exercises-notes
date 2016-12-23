;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designing_functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Number String Image -> Image
; Stop! What does this function produce?
; This function produces an image

;Full example
; Number String Image -> Image                                 => function signature
; adds s to img, y pixels from top, 10 pixels to the left      => function purpose
; given:                                                       => example illustration
;    5 for y, 
;    "hello" for s, and
;    (empty-scene 100 100) for img
; expected: 
;    (place-image (text "hello" 10 "red") 10 5 ...)
;    where ... is (empty-scene 100 100)
;                                                              => function header/stub goes here
;                                                              => eventually state it as a template
;                                                              => test test test (based on the previously illustrated cases)
;Note that the example might be wrong, the function definition might be wrong (bug) or both might be wrong

;So nice I had to copy this
;"There is plenty of room left in programming for complicated errors; we have no need to waste our time on silly ones."
