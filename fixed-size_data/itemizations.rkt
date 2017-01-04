;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 53
; A LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight

; QUESTION. When they say "draw" world scenarios do they mean:
; - draw data examples with pen and paper?
; - draw data examples using drRacket?
; - specify examples of the previously defined itemization?

; Assuming the 3rd option:
; interpretation “height” refers to the distance between the
; top of the canvas and the reference point
; Examples:
; for height = HEIGHT, the rocket's reference point will be on the ground
; for height = 0, the rocket's reference point will be on the
; top edge of the canvas

; -------------------------------------------------------------------
; Exercise 54
; (string=? "resting" x) incorrect because if x is an Number the program
; will fail and exit with error (string=?: expects a string as 1st argument, given x)

; When x belongs to the first subclass of LRCD:
; [(string? x) (cond [(string=? "resting" x) ...]]

; -------------------------------------------------------------------
; Exercise 55
; (define (place-rocket x y) (place-image ROCKET x (- y CENTER) BACKG))
; Why is this a good ideia? -> Just got to General Torres!! Need to leave the train.