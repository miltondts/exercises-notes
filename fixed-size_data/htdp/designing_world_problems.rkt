;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designing_world_problems) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 39 - single point of control
; Exercise 40
; Exercise 41
(require (lib "2htdp/universe"))
(require (lib "2htdp/image"))

; Define the constants
(define WHEEL-RADIUS 25) ; this is the single variable used to scale the image
(define WHEEL-DISTANCE
  (* WHEEL-RADIUS 5))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define BOTH-WHEELS
  (overlay/xy WHEEL (* 4 WHEEL-RADIUS) 0 WHEEL))
(define CAR-BOTTOM
  (rectangle (* 4 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define CAR-TOP
  (rectangle (* 2 WHEEL-RADIUS) WHEEL-RADIUS "solid" "red"))
(define CAR
  (overlay/xy BOTH-WHEELS WHEEL-RADIUS (- 0 WHEEL-RADIUS) CAR-BOTTOM))

(define TRACK-LENGTH (* WHEEL-RADIUS 20))
(define Y-CAR (* WHEEL-RADIUS 3))
(define BACKGROUND (empty-scene TRACK-LENGTH (* WHEEL-RADIUS 5)))

; Specify the data representation
; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the car

; Design the functions
; WorldState -> WorldState 
; moves the car by 3 pixels for every clock  tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  (+ ws 3))

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
 (define (render ws)
   (place-image CAR ws Y-CAR BACKGROUND))

(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 100) (place-image CAR 100 Y-CAR BACKGROUND))
(check-expect (render 150) (place-image CAR 150 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))

; end?: WorldState -> Boolean
; when needed, big-bang evaluates (end? cw) to determine
; whether the program should stop
(define (end? ws)
  (= ws TRACK-LENGTH))

(check-expect (end? 0) #false)
(check-expect (end? (* WHEEL-RADIUS 20)) #true)
(check-expect (end? (* WHEEL-RADIUS 10)) #false)

; Define the main function
; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when end?]))

(main 0)
