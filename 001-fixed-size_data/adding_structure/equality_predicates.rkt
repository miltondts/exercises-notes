;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname equality_predicates) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define MESSAGE
  "traffic light expected, given: some other value")
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal
 
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
 
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error MESSAGE)))

; ------------------------------------------------------------------------------
; Exercise 115

(define 1ST-ARGUMENT "1st argument is not a TrafficLight")
(define 2ND-ARGUMENT "2nd argument is not a TrafficLight")

(check-error (light.v2=? 10 "yellow") 1ST-ARGUMENT)
(check-error (light.v2=? "red" #false) 2ND-ARGUMENT)
(check-expect (light.v2=? "green" "green") #true)
(check-expect (light.v2=? "green" "yellow") #false)

(define (light.v2=? a-value another-value)
  (if (light? a-value)
      (if (light? another-value)
          (string=? a-value another-value)
          (error 2ND-ARGUMENT))
      (error 1ST-ARGUMENT)))
