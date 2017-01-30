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
(define BALL-HEIGHT 3)
(define BALL (square BALL-HEIGHT "solid" "black"))
(define FIELD (add-line CANVAS (/ FIELD-WIDTH 2) 0 (/ FIELD-WIDTH 2) FIELD-HEIGHT (pen "black" PLAYER-WIDTH "short-dash" "butt" "bevel")))

(define-struct player [pos score])
; Player is a structure
; (make-player Posn Number)
; interpretation information regarding a player. pos stores the x and y
; coordinates of where the player is, dir is the direction (-1 if going up,
; 1 if going down) the player is heading and score is a non negative number,
; starting at 0, that represents the player's score

(define example1 (make-player (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ FIELD-HEIGHT 2)) 0))
(define example2 (make-player (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) 0) 0))
(define example3 (make-player (make-posn (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) FIELD-HEIGHT) 0))
(define example4 (make-player (make-posn (/ PLAYER-WIDTH 2) (/ FIELD-HEIGHT 2)) 0))

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

(check-expect (render-player example1)
              (place-image PLAYER (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ FIELD-HEIGHT 2) FIELD))
; Player -> Image
(define (render-player p)
  (place-image PLAYER (posn-x (player-pos p)) (posn-y (player-pos p)) FIELD))

; ------------------------------------------------------------------------------
; Player KeyEvent -> Player
; move player up and down the y axis when the "w" and "s" key's are pressed,
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
    [else p]
    ))

; ------------------------------------------------------------------------------
(define-struct both-players [p1 p2])
; Both-players is a structure
; (make-both-players Player Player)
; interpretation information regarding player1's location and player2's location

; Both-players Key-Event -> Both-players
(define (move-p1 p ke)
  (make-both-players
   (move-player1 (both-players-p1 p ) ke)
   (both-players-p2 p)))
  
; Both-players KeyEvent -> Both-players
(define (move-p2 p ke)
   (make-both-players
    (both-players-p1 p)
    (move-player2 (both-players-p2 p) ke)))
 
; Both-players -> Image
; print a scene withg both players 
(define (render-both-players p)
  (place-image PLAYER (posn-x (player-pos (both-players-p1 p))) (posn-y (player-pos (both-players-p1 p)))
               (place-image PLAYER (posn-x (player-pos (both-players-p2 p))) (posn-y (player-pos (both-players-p2 p))) FIELD)))

(define (test-both p)
  (big-bang p
   [to-draw render-both-players]
   [on-key move-p1]
   [on-release move-p2]))

; ------------------------------------------------------------------------------
(define-struct ball [pos vel])
; Ball is a structure
; (make-ball Posn Posn)
; interpretation pos represents where the ball is (it's x and y coordinates)

; Ball -> Ball
; move the ball accross the field
; change y-direction when reaching the upper and lower limits of the field
; whishlist:
; - ball should only start moving when space is pressed;
; - ball should be placed again in the field once it goes out the left
; and right limits

(define (move-ball b)
  (cond
    [(> (posn-x (ball-pos b)) FIELD-WIDTH)
     (make-ball
      (make-posn 0 0)
      (make-posn 1 1))]
    [else
     (make-ball
      (make-posn
       (+ (posn-x (ball-pos b)) (posn-x (ball-vel b)))
       (+ (posn-y (ball-pos b)) (posn-y (ball-vel b))))
      (cond
        [(>= (posn-y (ball-pos b)) (- FIELD-HEIGHT (posn-y (ball-vel b))))
         (make-posn
          (posn-x (ball-vel b))
          (* (posn-y (ball-vel b)) -1))]
        [(<= (posn-y (ball-pos b)) (- 0 (posn-y (ball-vel b))))
         (make-posn
          (posn-x (ball-vel b))
          (* (posn-y (ball-vel b)) -1))]
        [else (ball-vel b)])
      )]
     ))

; Ball -> Image
; draw the ball in the field
(define (render-ball  b)
    (place-image BALL (posn-x (ball-pos b)) (posn-y (ball-pos b)) FIELD))

(define (baller p)
  (big-bang p
   [to-draw render-ball]
   [on-tick move-ball]))

; ------------------------------------------------------------------------------
(define-struct pong [p1 p2 ball])
; Pong is a structure
; (make-pong Player Player Ball)
; interpretation pong represents the position (x and y coordinates) of both
; players and of the ball

; Pong -> Image
; draw the ball and the players in the field
(define (render-pong p)
    (overlay
     (render-ball (pong-ball p))
     (render-player (pong-p1 p))
     (render-player (pong-p2 p))))


;(define (pong p)
;  (big-bang p
;   [to-draw render-pong]
;   [on-tick move-pong-ball]
;   [on-key move-pong-p1]
;   [on-release move-pong-p2]))