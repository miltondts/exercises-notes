;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 156-lists_and_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require (lib "2htdp/image"))
(require (lib "2htdp/universe"))

(define HEIGHT 80) ; distances in terms of pixels
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))

; graphical constants
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; ShotWorld -> ShotWorld
(define (main w0)
  (big-bang w0
            [on-tick tock]
            [on-key keyh]
            [to-draw to-image]))

; ShotWorld -> ShotWorld
; moves each shot up by one pixel
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld
; adds a shot to the world if the space bar was hit
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

; ShotWorld -> Image
; adds each shot y on w at (XSHOTS,y} to BACKGROUND
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))


; Exercise 156
(check-expect (tock '()) '())
(check-expect (tock (cons 9 '())) (cons 8 '()))
(check-expect (tock (cons 5 (cons 12 '()))) (cons 4 (cons 11 '())))

(check-expect (keyh '() "k") '())
(check-expect (keyh '() " ") (cons HEIGHT '()))

(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image '()) BACKGROUND)

; main:
; - takes a ShotWorld list and returns a ShotWorld list with the current state of the world
; - decreases each position in the list by 1 on every clock tick
; - draws a red triangel in all y positions of the list of numbers
; - (launches a new red triangle) adds a new position to the list when a " " is pressed

(main (cons 5 (cons 12 '())))