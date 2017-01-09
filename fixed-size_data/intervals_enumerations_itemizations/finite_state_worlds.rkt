;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname finite_state_worlds) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 59
(require (lib "2htdp/image"))
(require (lib "2htdp/universe"))

; 1) Set the constants
(define RADIUS 20)
(define HEIGHT (* 2 RADIUS))
(define WIDTH (* 8 RADIUS))
(define BKGND (empty-scene WIDTH HEIGHT))
(define R-CIRCLE (circle RADIUS "solid" "red"))
(define Y-CIRCLE (circle RADIUS "solid" "yellow"))
(define G-CIRCLE (circle RADIUS "solid" "green"))
(define R-CIRCUNF (circle RADIUS "outline" "red"))
(define Y-CIRCUNF (circle RADIUS "outline" "yellow"))
(define G-CIRCUNF (circle RADIUS "outline" "green"))
(define R-LIGHT (place-image R-CIRCLE RADIUS RADIUS
                             (place-image Y-CIRCUNF (* 4 RADIUS) RADIUS
                                          (place-image G-CIRCUNF (* 7 RADIUS) RADIUS BKGND))))
(define Y-LIGHT (place-image R-CIRCUNF RADIUS RADIUS
                             (place-image Y-CIRCLE (* 4 RADIUS) RADIUS
                                          (place-image G-CIRCUNF (* 7 RADIUS) RADIUS BKGND))))
(define G-LIGHT (place-image R-CIRCUNF RADIUS RADIUS
                             (place-image Y-CIRCUNF (* 4 RADIUS) RADIUS
                                          (place-image G-CIRCLE (* 7 RADIUS) RADIUS BKGND))))

; 2) Define the data representation
; A TrafficLight is one of:
; – red
; – green
; – yellow

; 3) Define the functions

; TrafficLight -> TrafficLight
; yields the next state given current state cs
(define (tl-next cs)
  (cond
    [(string=? "red" cs) "green"]
    [(string=? "green" cs) "yellow"]
    [(string=? "yellow" cs) "red"]))

(check-expect (tl-next "red") "green")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "green") "yellow")
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render cs)
    (cond
    [(string=? "red" cs) R-LIGHT]
    [(string=? "green" cs) G-LIGHT]
    [(string=? "yellow" cs) Y-LIGHT]))

; And the tests
(check-expect (tl-render "red") R-LIGHT)
(check-expect (tl-render "yellow") Y-LIGHT)
(check-expect (tl-render "green") G-LIGHT)

; 4) Set the main
; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))


; ------------------------------------------------------------------------------
; Exercise 60
; A N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow

; N-TrafficLight -> N-TrafficLight
; yields the next state given current state cs
(define (tl-next-numeric cs) (modulo (+ cs 1) 3))
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

; Does the tl-next function convey its intention more clearly than the
; tl-next-numeric function? If so, why? If not, why not?

; I believe that the tl-next function is clearer that the tl-next-numeric for
; this case because it gives the direct meaning of the state it is in. (You
; know a traffic light is red, but you can't be sure it's red if it's simply
; number 0)
; However, the intentation to move between sequential states is clearer in
; tl-next-numeric

; ------------------------------------------------------------------------------
; Exercise 61
; tl-next-numeric is correctly designed using the design recipe for itemization
; given it states a clear interval.
; tl-next-symbolic is the generic enough to work both if the state is Numeric
; or a String (as enumerations)


; ------------------------------------------------------------------------------
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

; DoorState -> DoorState
; closes an open door over the period of one tick
(check-expect (door-close LOCKED) LOCKED)
(check-expect (door-close CLOSED) CLOSED)
(check-expect (door-close OPEN) CLOSED)

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))

