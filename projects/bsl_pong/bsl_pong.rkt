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
(define example4 (make-player (make-posn (/ PLAYER-WIDTH 2) (/ FIELD-HEIGHT 2)) 0))
(define example5 (make-player (make-posn (/ PLAYER-WIDTH 2) 0) 0))
(define example6 (make-player (make-posn (/ PLAYER-WIDTH 2) FIELD-HEIGHT) 0))

(check-expect (move-player2 example4 "w")
              (make-player
               (make-posn (/ PLAYER-WIDTH 2) (- (/ FIELD-HEIGHT 2)  PLAYER-SPEED))
               0))
(check-expect (move-player2 example4 "s")
              (make-player
               (make-posn (/ PLAYER-WIDTH 2) (+ (/ FIELD-HEIGHT 2)  PLAYER-SPEED))
               0))
(check-expect (move-player2 example4 "up") example4)
(check-expect (move-player2 example5 "w")
              (make-player
               (make-posn (/ PLAYER-WIDTH 2) (/ PLAYER-HEIGHT 2))
               0))
(check-expect (move-player2 example6 "s")
              (make-player
               (make-posn (/ PLAYER-WIDTH 2) (- FIELD-HEIGHT (/ PLAYER-HEIGHT 2)))
               0))

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

(define example7 (make-both-players example1 example4))

(check-expect (move-p1 example7 "up")
              (make-both-players
               (move-player1 example1 "up")
               example4))
(check-expect (move-p1 example7 "w")
              (make-both-players
               example1
               example4))
; Both-players Key-Event -> Both-players
(define (move-p1 p ke)
  (make-both-players
   (move-player1 (both-players-p1 p ) ke)
   (both-players-p2 p)))

(check-expect (move-p2 example7 "up")
              (make-both-players
               example1
               example4))
(check-expect (move-p2 example7 "w")
              (make-both-players
               example1
               (move-player2 example4 "w")))
; Both-players KeyEvent -> Both-players
(define (move-p2 p ke)
   (make-both-players
    (both-players-p1 p)
    (move-player2 (both-players-p2 p) ke)))

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

(check-expect (move-ball example8)
              (make-ball
               (make-posn 1 1)
               (make-posn 1 1)))
(check-expect (move-ball example9)
              (make-ball
               (make-posn 0 0)
               (make-posn 1 1)))
(check-expect (move-ball example10)
              (make-ball
               (make-posn 3 FIELD-HEIGHT)
               (make-posn 1 -1)))
(check-expect (move-ball example11)
              (make-ball
               (make-posn 3 0)
               (make-posn 1 1)))
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
                          
; Pong -> Pong
; ball motion and interactions between it, the player cursors, the upper and
; lower bounds of the field and the left and right bound of the field
(define (move-pong-ball p)
  (make-pong
   (cond
     [(< (posn-x (ball-pos (pong-ball p))) (- 0 (posn-x (ball-vel (pong-ball p)))))
      (make-player
       (make-posn
        (posn-x (player-pos (pong-p1 p)))
        (posn-y (player-pos (pong-p1 p))))
       (+ (player-score (pong-p1 p)) 1))]
     [else
     (pong-p1 p)])
   (cond
     [(> (posn-x (ball-pos (pong-ball p))) (+ FIELD-WIDTH (posn-x (ball-vel (pong-ball p)))))
      (make-player
       (make-posn
        (posn-x (player-pos (pong-p2 p)))
        (posn-y (player-pos (pong-p2 p))))
       (+ (player-score (pong-p2 p)) 1))]
     [else
     (pong-p2 p)])
   (cond
     [(< (posn-x (ball-pos (pong-ball p))) (- 0 (posn-x (ball-vel (pong-ball p)))))
      (make-ball
       (make-posn PLAYER-WIDTH 0)
       BALL-SPEED)]
     [(> (posn-x (ball-pos (pong-ball p))) (+ FIELD-WIDTH (posn-x (ball-vel (pong-ball p)))))
      (make-ball
       (make-posn PLAYER-WIDTH 0)
        BALL-SPEED)]
     [else
      (make-ball
       (make-posn
        (+ (posn-x (ball-pos (pong-ball p))) (posn-x (ball-vel (pong-ball p))))
        (+ (posn-y (ball-pos (pong-ball p))) (posn-y (ball-vel (pong-ball p)))))
       (cond
         [(>= (posn-y (ball-pos (pong-ball p))) (- FIELD-HEIGHT (posn-y (ball-vel (pong-ball p)))))
          (make-posn
           (posn-x (ball-vel (pong-ball p)))
           (* (posn-y (ball-vel (pong-ball p))) -1))]
         [(<= (posn-y (ball-pos (pong-ball p))) (- 0 (posn-y (ball-vel (pong-ball p)))))
          (make-posn
           (posn-x (ball-vel (pong-ball p)))
           (* (posn-y (ball-vel (pong-ball p))) -1))]
         [(and
           (>= (posn-x (ball-pos (pong-ball p))) (- (- FIELD-WIDTH PLAYER-WIDTH) (posn-x (ball-vel (pong-ball p)))))
           (and
            (>= (posn-y (ball-pos (pong-ball p))) (- (posn-y (player-pos (pong-p1 p))) (/ PLAYER-HEIGHT 2)))
            (<= (posn-y (ball-pos (pong-ball p))) (+ (posn-y (player-pos (pong-p1 p))) (/ PLAYER-HEIGHT 2)))))
          (make-posn
           (* (posn-x (ball-vel (pong-ball p))) -1)
           (posn-y (ball-vel (pong-ball p))))]
         [(and
           (<= (posn-x (ball-pos (pong-ball p))) (- PLAYER-WIDTH (posn-x (ball-vel (pong-ball p)))))
           (and
            (>= (posn-y (ball-pos (pong-ball p))) (- (posn-y (player-pos (pong-p2 p))) (/ PLAYER-HEIGHT 2)))
            (<= (posn-y (ball-pos (pong-ball p))) (+ (posn-y (player-pos (pong-p2 p))) (/ PLAYER-HEIGHT 2)))))
          (make-posn
           (* (posn-x (ball-vel (pong-ball p))) -1)
           (posn-y (ball-vel (pong-ball p))))]
         [else (ball-vel (pong-ball p))])
       )]
     )))

(define (move-pong-p1 p ke)
  (make-pong
   (move-player1 (pong-p1 p) ke)
   (pong-p2 p)
   (pong-ball p)))

(define (move-pong-p2 p ke)
  (make-pong
   (pong-p1 p)
   (move-player2 (pong-p2 p) ke)
   (pong-ball p)))

(define (ponger p)
  (big-bang p
   [to-draw render-pong]
   [on-tick move-pong-ball]
   [on-key move-pong-p1]
   [on-release move-pong-p2]))

(ponger (make-pong example1 example4 (make-ball (make-posn 0 0) (make-posn 3 1))))