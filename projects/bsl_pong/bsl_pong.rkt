;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bsl_pong) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; BSL PONG
; Whishlist:
; - a white canvas;
; - 2 black players (rectangles);
; - a net;
; - a score board (one number on each side of the field)
; - a ball
(require "lib/image")

(define FIELD-HEIGHT 200)
(define FIEL-WIDTH 20)
(define FIELD (empty-scene FIELD-WIDTH FIELD-HEIGHT))
(define PLAYER-HEIGHT (/ FIELD-HEIGHT 10))
(define PLAYER-WIDHT (/ FIELD-WIDTH 100))
(define PLAYER (rectangle PLAYER-WIDTH PLAYER-HEIGHT "solid" "black"))

(define-struct player [location dir score])
; Player is a structure
; (make-player Posn Number Score)
; interpretation information regarding a player. location stores the x and y
; coordinates of where the player is, dir is the direction (-1 if going up,
; 1 if going down) the player is heading and score is a non negative number,
; starting at 0, that represents the player's score

(define-struct ball [location velocity])
; Ball is a structure
; (make-ball Posn Number)
; interpretation location represents where the ball is (it's x and y coordinates)
; and velocity is an Integer for the direction and speed of the ball 
