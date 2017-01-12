;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname programming_with_posn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; computes the distance of ap to the origin 
(define (distance-to-0 ap)
  (sqrt
   (+ (sqr (posn-x ap))
      (sqr (posn-y ap)))))

(check-expect (distance-to-0 (make-posn 0 5)) 5)
(check-expect (distance-to-0 (make-posn 7 0)) 7)
(check-expect (distance-to-0 (make-posn 3 4)) 5)
(check-expect (distance-to-0 (make-posn 8 6)) 10)
(check-expect (distance-to-0 (make-posn 5 12)) 13)

; Exercise 63
(distance-to-0 (make-posn 3 4))          ; == 5
; substitutes distance-to-0 by its definition
; substitutes posn-x by its value and calculates its square
; does the same for y
; adds the squares of x and y
; performs the sqrt of the result
(distance-to-0 (make-posn 6 (* 2 4)))    ; == 10
; multiplies 2 by 4 and uses this value as y
; substitutes distance-to-0 by its definition
; substitutes posn-x by its value and calculates its square
; does the same for y
; adds the squares of x and y
; performs the sqrt of the result
(+ (distance-to-0 (make-posn 12 5)) 10)  ; == 23
; substitutes distance-to-0 by its definition
; substitutes posn-x by its value and calculates its square
; does the same for y
; adds the squares of x and y
; performs the sqrt of the result
; adds 10 with to the previous result

; Exercise 64
; Stop! Does it matter which strategy you follow?
; No, because both will convey the same amount of steps
(check-expect (manhattan-distance (make-posn 5 4)) 9)
(define (manhattan-distance ap) (+ (posn-x ap) (posn-y ap)))
