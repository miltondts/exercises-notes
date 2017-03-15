;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname enumerations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 50
; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 

; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
; When not all conditions are tested, DrRacket highlights the missing condition tests
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; Exercise 51
; I'll bet the appropiate initial stage is a red light because we'll
; guarantee the cars are stopped before starting the whole system
(require (lib "2htdp/universe"))
(require (lib "2htdp/image"))

(define LIGHT-RADIUS 20)
(define LIGHT-SWITCH-PERIOD 10)

(define (render-light tl)
  (circle LIGHT-RADIUS "solid" tl)
  )

(check-expect (render-light "red") (circle LIGHT-RADIUS "solid" "red"))

(define (main tl)
  (big-bang tl
            [on-tick traffic-light-next LIGHT-SWITCH-PERIOD]
            [to-draw render-light]))

(main "red")