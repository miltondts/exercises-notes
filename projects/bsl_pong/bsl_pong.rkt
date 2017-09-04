;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname bsl_pong) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
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
(define BALL-SPEED (make-posn 3 1))

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

(define (imove-player p direction)
  (make-player
   (make-posn (posn-x (player-pos p)) (+ (posn-y (player-pos p)) (* direction PLAYER-SPEED)))
   (player-score p)))

(define (hit-upper-wall? p)
  (< (posn-y (player-pos p)) (/ PLAYER-HEIGHT 2)))

(define (hit-lower-wall? p)
  (> (posn-y (player-pos p)) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2))))

(define (hit-wall? p)
  (or (hit-upper-wall? p)
      (hit-lower-wall? p)))
  
; Player KeyEvent -> Player
; move player up and down the y axis when the "up" and "down" key's are pressed,
; accordingly
(define (move-player p direction)
  (let [(np (imove-player p direction))]
    (if (hit-wall? np)
        p
        np)))
  
(check-expect (render-player example1)
              (place-image PLAYER (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ FIELD-HEIGHT 2) FIELD))
; Player -> Image
(define (render-player p)
  (place-image PLAYER (posn-x (player-pos p)) (posn-y (player-pos p)) FIELD))

; ------------------------------------------------------------------------------
(define example4 (make-player (make-posn (/ PLAYER-WIDTH 2) (/ FIELD-HEIGHT 2)) 0))
(define example5 (make-player (make-posn (/ PLAYER-WIDTH 2) 0) 0))
(define example6 (make-player (make-posn (/ PLAYER-WIDTH 2) FIELD-HEIGHT) 0))

; ------------------------------------------------------------------------------
(define-struct both-players [p1 p2])
; Both-players is a structure
; (make-both-players Player Player)
; interpretation information regarding player1's location and player2's location

(define example7 (make-both-players example1 example4))


(check-expect (render-both-players example7)
              (place-image PLAYER (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) (/ FIELD-HEIGHT 2)
                           (place-image PLAYER (/ PLAYER-WIDTH 2) (/ FIELD-HEIGHT 2) FIELD)))
; Both-players -> Image
; print a scene withg both players 
(define (render-both-players p)
  (place-image PLAYER (posn-x (player-pos (both-players-p1 p))) (posn-y (player-pos (both-players-p1 p)))
               (place-image PLAYER (posn-x (player-pos (both-players-p2 p))) (posn-y (player-pos (both-players-p2 p))) FIELD)))

; ------------------------------------------------------------------------------
(define-struct ball [pos vel])
; Ball is a structure
; (make-ball Posn Posn)
; interpretation pos represents where the ball is (it's x and y coordinates)

(define example8 (make-ball (make-posn 0 0) (make-posn 1 1)))
(define example9 (make-ball (make-posn (+ FIELD-WIDTH 2) 0) (make-posn 1 1)))
(define example10 (make-ball (make-posn 2 (- FIELD-HEIGHT 1)) (make-posn 1 1)))
(define example11 (make-ball (make-posn 2 1) (make-posn 1 -1)))

(check-expect (render-ball example8)
              (place-image BALL 0 0 FIELD))
; Ball -> Image
; draw the ball in the field
(define (render-ball  b)
    (place-image BALL (posn-x (ball-pos b)) (posn-y (ball-pos b)) FIELD))

; ------------------------------------------------------------------------------
(define-struct pong [p1 p2 ball])
; Pong is a structure
; (make-pong Player Player Ball)
; interpretation pong represents the position (x and y coordinates) of both
; players and of the ball


; Player -> Image
(define (text-score p)
  (text (number->string (player-score  p)) 36 "black"))

; Pong -> Image
; draw the ball and the players in the field
(define (render-pong p)
    (place-image PLAYER (posn-x (player-pos (pong-p1 p))) (posn-y (player-pos (pong-p1 p)))
                 (place-image (text-score (pong-p1 p)) (+ (/ FIELD-WIDTH 2) (/ FIELD-WIDTH 4)) (/ FIELD-HEIGHT 4) 
                              (place-image PLAYER (posn-x (player-pos (pong-p2 p))) (posn-y (player-pos (pong-p2 p)))
                                           (place-image (text-score (pong-p2 p))  (- (/ FIELD-WIDTH 2) (/ FIELD-WIDTH 4)) (/ FIELD-HEIGHT 4)                   
                                                        (place-image BALL (posn-x (ball-pos (pong-ball p))) (posn-y (ball-pos (pong-ball p))) FIELD))))))

(define example12 (make-ball (make-posn
                              (- 0 2) 2)
                             (make-posn
                              1 1)))
(define example13 (make-ball (make-posn
                              (- (- FIELD-WIDTH (/ PLAYER-WIDTH 2)) 1) (/ FIELD-HEIGHT 2))
                             (make-posn
                              1 1)))


; Ball inside the field, moving normally
(check-expect (move-pong-ball
               (make-pong example1 example4 example8))
              (make-pong example1 example4 (make-ball
                                            (make-posn 1 1)
                                            (make-posn 1 1))))
; Ball hits the upper edge
(check-expect (move-pong-ball
               (make-pong example1 example4 example11))
              (make-pong example1 example4 (make-ball
                                            (make-posn 3 0)
                                            (make-posn 1 1))))
; Ball hits the lower edge
(check-expect (move-pong-ball
               (make-pong example1 example4 example10))
              (make-pong example1 example4 (make-ball
                                            (make-posn 3 FIELD-HEIGHT)
                                            (make-posn 1 -1))))
; Ball goes through the right edge
; Ball goes through the left edge

; Ball hits player1                                            
; Ball hits player2


(define (update-score p)
  (make-player
   (make-posn
    (posn-x (player-pos p))
    (posn-y (player-pos p)))
   (+ (player-score p) 1)))

(define (goal? ball)
  (or (p1-goal? ball) (p2-goal? ball)))

(define (update-player ball p goal?)
  (if (goal? ball)
      (update-score p)
      p))

(define (p1-goal? ball)
  (> (posn-x (ball-pos ball))
     (+ FIELD-WIDTH (posn-x (ball-vel ball)))))

(define (p2-goal? ball)
  (< (posn-x (ball-pos ball))
     (- 0 (posn-x (ball-vel ball)))))

(define initial-ball
  (make-ball
   (make-posn PLAYER-WIDTH 0)
   BALL-SPEED))

(define (update-ball-pos ball)
  (make-posn
         (+ (posn-x (ball-pos ball)) (posn-x (ball-vel ball)))
         (+ (posn-y (ball-pos ball)) (posn-y (ball-vel ball)))))

(define (update-ball-vel ball p1 p2)
   (cond
     [(hit-upper-bound? ball) (reflect-ball-y ball)]
     [(hit-lower-bound? ball) (reflect-ball-y ball)]
     [(hit-p1? ball p1) (reflect-ball-x ball)]
     [(hit-p2? ball p2) (reflect-ball-x ball)]
     [else (ball-vel ball)]))

(define (hit-upper-bound? ball)
  (>= (posn-y (ball-pos ball)) (- FIELD-HEIGHT (posn-y (ball-vel ball)))))

(define (hit-lower-bound? ball)
  (<= (posn-y (ball-pos ball)) (- 0 (posn-y (ball-vel ball)))))

(define (hit-p1? ball p1)
  (and
   (>= (posn-x (ball-pos ball)) (- (- FIELD-WIDTH PLAYER-WIDTH) (posn-x (ball-vel ball))))
   (>= (posn-y (ball-pos ball)) (- (posn-y (player-pos p1)) (/ PLAYER-HEIGHT 2)))
   (<= (posn-y (ball-pos ball)) (+ (posn-y (player-pos p1)) (/ PLAYER-HEIGHT 2)))))

(define (hit-p2? ball p2)
  (and
   (<= (posn-x (ball-pos ball)) (- PLAYER-WIDTH (posn-x (ball-vel ball))))
   (>= (posn-y (ball-pos ball)) (- (posn-y (player-pos p2)) (/ PLAYER-HEIGHT 2)))
   (<= (posn-y (ball-pos ball)) (+ (posn-y (player-pos p2)) (/ PLAYER-HEIGHT 2)))))

(define (reflect-ball-y ball)
  (make-posn
   (posn-x (ball-vel ball))
   (* (posn-y (ball-vel ball)) -1)))

(define (reflect-ball-x ball)
  (make-posn
   (* (posn-x (ball-vel ball)) -1)
   (posn-y (ball-vel ball))))

(define (update-ball p)
   (if (goal? (pong-ball p))
       initial-ball
       (make-ball
        (update-ball-pos (pong-ball p))
        (update-ball-vel (pong-ball p) (pong-p1 p) (pong-p2 p)))))

; Pong -> Pong
; ball motion and interactions between it, the player cursors, the upper and
; lower bounds of the field and the left and right bound of the field
(define (move-pong-ball p)
  (make-pong
   (update-player (pong-ball p) (pong-p1 p) p1-goal?)
   (update-player (pong-ball p) (pong-p2 p) p2-goal?)
   (update-ball p)))

(define DIRECTION-UP -1)
(define DIRECTION-DOWN 1)
(define DIRECTION-STAY 0)

(define (key->direction ke up-key down-key)
  (cond
    [(string=? ke up-key) DIRECTION-UP]
    [(string=? ke down-key) DIRECTION-DOWN]
    [else DIRECTION-STAY]))

(define (move-pong-p1 p ke)
  (make-pong
   (move-player (pong-p1 p) (key->direction ke "up" "down"))
   (pong-p2 p)
   (pong-ball p)))

(define (move-pong-p2 p ke)
  (make-pong
   (pong-p1 p)
   (move-player (pong-p2 p) (key->direction ke "w" "s"))
   (pong-ball p)))

(define (ponger p)
  (big-bang p
   [to-draw render-pong]
   [on-tick move-pong-ball]
   [on-key move-pong-p1]
   [on-release move-pong-p2]))

(ponger (make-pong example1 example4 (make-ball (make-posn 0 0) (make-posn 3 1))))