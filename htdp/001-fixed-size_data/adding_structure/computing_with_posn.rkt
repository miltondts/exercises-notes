;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname computing_with_posn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Stop! Confirm the second interaction above with your own computation
; Also use DrRacket’s stepper to double-check.
(define p (make-posn 31 26))

(posn-x p)
(posn-y p)

(posn-x (make-posn 31 26))
(posn-y (make-posn 31 26))