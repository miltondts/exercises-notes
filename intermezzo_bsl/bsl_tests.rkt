;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bsl_tests) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 128

(check-expect 3 4) ; => compares the outcome and the expecte value with equal?, however, the value differ
(check-member-of "green" "red" "yellow" "grey") ; => compares the outcome "grey" with the expected values "green", "red" and "yellow", but "grey" is not a member of this collection
(check-within (make-posn #i1.0 #i1.1) (make-posn #i0.9 #i1.2) 0.01) ; => (make-posn i0.9 i1.2) differs by an epsilon of 0.1 from the input, not 0.01
(check-range #i0.9 #i0.6 #i0.8) ; the value i0.9 is not between i0.6 and i0.8
(check-error (/ 1 1)) ; => (/ 1 1) = 1, so this does not return an error
(check-random (make-posn (random 3) (random 9)) (make-posn (random 9) (random 3))) ; => the y and x are switched in the outcome and expected value
(check-satisfied 4 odd?) ; 4 is even, so the condition is not satisfied
