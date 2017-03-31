;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 157-lists_and_world) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require (lib "2htdp/image"))
(require (lib "2htdp/universe"))

(define HEIGHT 220) ; distances in terms of pixels
(define WIDTH 30)
(define XSHOTS (/ WIDTH 4))

; graphical constants
(define BACKGROUND (rectangle WIDTH HEIGHT "solid" "green"))
(define SHOT (isosceles-triangle 6 30 "solid" "black"))

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

(main '())