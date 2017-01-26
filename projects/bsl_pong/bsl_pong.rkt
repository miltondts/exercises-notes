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
(require 2htdp/image)
(require 2htdp/universe)

(define FIELD-HEIGHT 200)
(define FIELD-WIDTH (* FIELD-HEIGHT 2))
(define CANVAS (empty-scene FIELD-WIDTH FIELD-HEIGHT))
(define PLAYER-HEIGHT (/ FIELD-HEIGHT 8))
(define PLAYER-WIDTH (/ FIELD-WIDTH 80))
(define PLAYER-SPEED 3)
(define PLAYER (rectangle PLAYER-WIDTH PLAYER-HEIGHT "solid" "black"))
(define FIELD (add-line CANVAS (/ FIELD-WIDTH 2) 0 (/ FIELD-WIDTH 2) FIELD-HEIGHT (pen "black" PLAYER-WIDTH "short-dash" "butt" "bevel")))

(define-struct player [pos score])
; Player is a structure
; (make-player Posn Number Score)
; interpretation information regarding a player. pos stores the x and y
; coordinates of where the player is, dir is the direction (-1 if going up,
; 1 if going down) the player is heading and score is a non negative number,
; starting at 0, that represents the player's score

(define-struct ball [pos vel])
; Ball is a structure
; (make-ball Posn Number)
; interpretation pos represents where the ball is (it's x and y coordinates)
; and vel is an Integer for the direction and speed of the ball

(define example1 (make-player (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ FIELD-HEIGHT 2)) 0))
(define example2 (make-player (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) 0) 0))
(define example3 (make-player (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) FIELD-HEIGHT) 0))

(check-expect (move-player1 example1 "up")
              (make-player
               (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (- (/ FIELD-HEIGHT 2) PLAYER-SPEED))
               0))
(check-expect (move-player1 example1 "down")
              (make-player
               (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (+ (/ FIELD-HEIGHT 2) PLAYER-SPEED))
               0))
(check-expect (move-player1 example2 "up")
              (make-player
               (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ PLAYER-HEIGHT 2))
               0))
(check-expect (move-player1 example3 "down")
              (make-player
               (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2)))
               0))
; Player KeyEvent -> Player
; move player up and down the y axis when the "up" and "down" key's are pressed,
; accordingly
(define (move-player1 p ke)
  (cond
    [(> (posn-y (player-pos p)) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2)))
     (make-player
     (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2)))
     (player-score p)) ]
    [(< (posn-y (player-pos p)) (/ PLAYER-HEIGHT 2))
     (make-player
     (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ PLAYER-HEIGHT 2))
     (player-score p))]
    [(string=? ke "up")
    (make-player
     (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (- (posn-y (player-pos p)) PLAYER-SPEED))
     (player-score p))]
    [(string=? ke "down")
    (make-player
     (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (+ (posn-y (player-pos p)) PLAYER-SPEED))
     (player-score p))]
    [else p]
    ))

; Player KeyEvent -> Player
; move player up and down the y axis when the "w" and "s" key's are pressed,
; accordingly
(define (move-player2 p ke)
  (cond
    [(> (posn-y (player-pos p)) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2)))
     (make-player
     (make-posn (/ PLAYER-WIDTH 2) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2)))
     (player-score p)) ]
    [(< (posn-y (player-pos p)) (/ PLAYER-HEIGHT 2))
     (make-player
     (make-posn (/ PLAYER-WIDTH 2) (/ PLAYER-HEIGHT 2))
     (player-score p))]
    [(string=? ke "w")
    (make-player
     (make-posn (/ PLAYER-WIDTH 2) (- (posn-y (player-pos p)) PLAYER-SPEED))
     (player-score p))]
    [(string=? ke "s")
    (make-player
     (make-posn (/ PLAYER-WIDTH 2) (+ (posn-y (player-pos p)) PLAYER-SPEED))
     (player-score p))]
    ))

(check-expect (render example1)
              (place-image PLAYER (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ FIELD-HEIGHT 2) FIELD))
; Player -> Image
(define (render p)
  (place-image PLAYER (posn-x (player-pos p)) (posn-y (player-pos p)) FIELD))

(define (pong p)
  (big-bang p
   [to-draw render]
   [on-key move-player1]))
