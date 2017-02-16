;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname design_with_itemizations_again) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Designing with Itemizations, Again
; Exercise 94
(require (lib "2htdp/image"))
(require (lib "2htdp/universe"))

(define CANVAS-COLOR "blue")
(define TANK-COLOR "green")
(define UFO-COLOR "green")
(define CANVAS-WIDTH 180)
(define CANVAS-HEIGHT 320)
(define TANK-WIDTH (/ CANVAS-WIDTH 10))
(define TANK-HEIGHT (/ CANVAS-HEIGHT 10))
(define UFO-DIAMETER (/ CANVAS-WIDTH 15))
(define UFO-PLATE (rectangle (* UFO-DIAMETER 3) (/ UFO-DIAMETER 5) "solid" UFO-COLOR))
(define BCKGRND (empty-scene CANVAS-WIDTH CANVAS-HEIGHT CANVAS-COLOR))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" TANK-COLOR))
(define UFO (overlay UFO-PLATE (circle UFO-DIAMETER "solid" UFO-COLOR)))
(define MISSILE (triangle (/ TANK-HEIGHT 10) "solid" "red"))
(define UFO-SPEED 1)
(define MISSILE-SPEED UFO-SPEED)

(place-image UFO (/ CANVAS-WIDTH 2) UFO-DIAMETER
             (place-image TANK (/ CANVAS-WIDTH 2) (- CANVAS-HEIGHT (/ TANK-HEIGHT 2)) BCKGRND))

; ------------------------------------------------------------------------------
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, CANVAS-HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game (Space Invader Game State)

; Example of stucture instances:
;(make-aim (make-posn 20 10) (make-tank 28 -3))

;(make-fired (make-posn 20 10)
;            (make-tank 28 -3)
;            (make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT)))

;(make-fired (make-posn 20 100)
;            (make-tank 100 3)
;            (make-posn 22 103))

;Exercise 95. Explain why the three instances are generated according to the
;             first or second clause of the data definition.
; The first and second clause are the data definitions of the UFO and of the
; TANK. Both these elements are present in the CANVAS throught the lifecyle
; of the Universe.
; Only when the UFO would explode, would it leave the CANVAS. But, in this case,
; the game would end.

; ------------------------------------------------------------------------------
; Exercise 96 - The sketches will be in the notebook

; ------------------------------------------------------------------------------
; SIGS -> Image
; renders the given game state on top of BACKGROUND 
; for examples see figure 32
(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BCKGRND))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BCKGRND)))]))

; ------------------------------------------------------------------------------
; Exercise 97
; The result should be the same because we are simply adding the images together
; (placing them on top of each other). Adding the UFO to a image with a tank, or
; a tank to an image with a UFO should be the same.
(define tank-ex1 (make-tank 10 3))
(check-expect (tank-render tank-ex1 BCKGRND)
              (place-image TANK 10 (- CANVAS-HEIGHT (/ TANK-HEIGHT 2)) BCKGRND))
; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (tank-loc t) (- CANVAS-HEIGHT (/ TANK-HEIGHT 2)) im))

(define ufo-ex1 (make-posn 10 10))
(check-expect (ufo-render ufo-ex1 BCKGRND)
              (place-image UFO 10 10 BCKGRND))
; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

(define missile-ex1 (make-posn 10 10))
(check-expect (missile-render missile-ex1 BCKGRND)
              (place-image MISSILE 10 10 BCKGRND))
; Missile Image -> Image 
; adds m to the given image im
(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))

; ------------------------------------------------------------------------------
; Exercise 98

(define aim-ex1 (make-aim (make-posn 20 10) (make-tank 28 -3)))
(define aim-ex2 (make-aim (make-posn 20 CANVAS-HEIGHT) (make-tank 28 -3)))

(define fired-ex1 (make-fired (make-posn 20 10)
                              (make-tank 28 -3)
                              (make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT))))
(define fired-ex2 (make-fired (make-posn 20 CANVAS-HEIGHT)
                              (make-tank 28 -3)
                              (make-posn 28 10)))
(define fired-ex3 (make-fired (make-posn 20 50)
                              (make-tank 28 -3)
                              (make-posn 20 50)))

(check-expect (si-game-over? aim-ex1) #false)
(check-expect (si-game-over? aim-ex2) #true)
(check-expect (si-game-over? fired-ex1) #false)
(check-expect (si-game-over? fired-ex2) #true)
(check-expect (si-game-over? fired-ex3) #true)

; SIGS -> Bool
; returns true if the UFO lands or if the missile hits the UFO, and retruns
; false otherwhise
(define (si-game-over? s)
  (cond
    [(aim? s)
     (cond
       [(>= (posn-y (aim-ufo s)) CANVAS-HEIGHT) #true]
       [else #false])]
    [(fired? s)
     (cond
       [(>= (posn-y (fired-ufo s)) CANVAS-HEIGHT) #true]
       [(and
         (<= (posn-y (fired-missile s)) (posn-y (fired-ufo s)))
         (<= (posn-x (fired-missile s)) (+ (posn-x (fired-ufo s)) UFO-DIAMETER))
         (>= (posn-x (fired-missile s)) (- (posn-x (fired-ufo s)) UFO-DIAMETER))) #true]
       [else #false])]))


; ------------------------------------------------------------------------------
; Exercise 99

(check-random
 (si-move aim-ex3)
 (si-move-proper aim-ex3 (random (- CANVAS-WIDTH UFO-DIAMETER))))
; SIGS -> SIGS
; determine to which position each of the elements of SIGS (missile, tank, UFO)
; move to
(define (si-move w)
  (si-move-proper w (random (- CANVAS-WIDTH UFO-DIAMETER))))

(define aim-ex3
  (make-aim
   (make-posn 20 10)
   (make-tank CANVAS-WIDTH 3)))
(define aim-ex4
  (make-aim
   (make-posn 20 10)
   (make-tank 0 -3)))
(define fired-ex4
  (make-fired
   (make-posn 20 50)
   (make-tank CANVAS-WIDTH 3)
   (make-posn 20 50)))
(define fired-ex5
  (make-fired
   (make-posn 20 50)
   (make-tank 0 -3)
   (make-posn 20 50)))

(check-expect (si-move-proper aim-ex1 3)
              (make-aim
               (make-posn 3 (+ 10 UFO-SPEED))
               (make-tank 25 -3)))
(check-expect (si-move-proper aim-ex3 3)
              (make-aim
               (make-posn 3 (+ 10 UFO-SPEED))
               (make-tank (- CANVAS-WIDTH 3) -3)))
(check-expect (si-move-proper aim-ex4 3)
              (make-aim
               (make-posn 3 (+ 10 UFO-SPEED))
               (make-tank 3 3)))
(check-expect (si-move-proper fired-ex1 3)
              (make-fired
               (make-posn 3 (+ 10 UFO-SPEED))
               (make-tank 25 -3)
               (make-posn 28 (- (- CANVAS-HEIGHT TANK-HEIGHT) MISSILE-SPEED))))
(check-expect (si-move-proper fired-ex4 3)
              (make-fired
               (make-posn 3 (+ 50 UFO-SPEED))
               (make-tank (- CANVAS-WIDTH 3) -3)
               (make-posn 20 (- 50 MISSILE-SPEED))))
(check-expect (si-move-proper fired-ex5 3)
              (make-fired
               (make-posn 3 (+ 50 UFO-SPEED))
               (make-tank 3 3)
               (make-posn 20 (- 50 MISSILE-SPEED))))

; SIGS Number -> SIGS 
; move the space-invader objects predictably by delta
(define (si-move-proper w delta)
  (cond
    [(fired? w)
     (make-fired
      (make-posn delta (+ (posn-y (fired-ufo w)) UFO-SPEED))
      (if
       (or
        (>= (tank-loc (fired-tank w)) CANVAS-WIDTH)
        (<= (tank-loc (fired-tank w)) 0))
       (make-tank (- (tank-loc (fired-tank w)) (tank-vel (fired-tank w))) (- 0 (tank-vel (fired-tank w))))
       (make-tank (+ (tank-loc (fired-tank w)) (tank-vel (fired-tank w))) (tank-vel (fired-tank w))))
      (make-posn (posn-x (fired-missile w)) (- (posn-y (fired-missile w)) MISSILE-SPEED)))]
    [else
     (make-aim
      (make-posn delta (+ (posn-y (aim-ufo w)) UFO-SPEED))
      (if
       (or
        (>= (tank-loc (aim-tank w)) CANVAS-WIDTH)
        (<= (tank-loc (aim-tank w)) 0))
       (make-tank (- (tank-loc (aim-tank w)) (tank-vel (aim-tank w))) (- 0 (tank-vel (aim-tank w))))
       (make-tank (+ (tank-loc (aim-tank w)) (tank-vel (aim-tank w))) (tank-vel (aim-tank w)))))]
    ))

; Stop! experiment with random
(random 42)
(random 69)
(random 666)
(random 1001)
(random 2020)

; ------------------------------------------------------------------------------
; Exercise 100

(define aim-ex5 (make-aim (make-posn 20 10) (make-tank 28 3)))

(check-expect (si-control aim-ex1 "right")
              (make-aim (make-posn 20 10) (make-tank 28 3)))
(check-expect (si-control aim-ex5 "right")
              (make-aim (make-posn 20 10) (make-tank 28 3)))
(check-expect (si-control aim-ex1 "left")
              (make-aim (make-posn 20 10) (make-tank 28 -3)))
(check-expect (si-control aim-ex1 "up")
              aim-ex1)
(check-expect (si-control aim-ex5 "right")
              (make-aim (make-posn 20 10) (make-tank 28 3)))
(check-expect (si-control aim-ex5 "left")
              (make-aim (make-posn 20 10) (make-tank 28 -3)))
(check-expect (si-control aim-ex1 " ")
              (make-fired (make-posn 20 10)
                              (make-tank 28 -3)
                              (make-posn 28 (- CANVAS-HEIGHT TANK-HEIGHT))))
(check-expect (si-control fired-ex3 " ")
              fired-ex3)
(check-expect (si-control fired-ex3 "right")
              (make-fired (make-posn 20 50)
                              (make-tank 28 3)
                              (make-posn 20 50)))
(check-expect (si-control fired-ex3 "left")
              fired-ex3)
(check-expect (si-control fired-ex3 "w")
              fired-ex3)
(check-expect (si-control fired-ex4 "left")
              (make-fired
               (make-posn 20 50)
               (make-tank CANVAS-WIDTH -3)
               (make-posn 20 50)))
(check-expect (si-control fired-ex4 "right")
              fired-ex4)

; SIGS KeyEvent -> SIGS
; pressing left ensure the tank goes to the left
; pressing right ensures the tank goes right
; pressing space bar launches the missile (if it hasn't already been launched)
(define (si-control w ke)
  (if (aim? w)
      (cond
        [(string=? "left" ke)
         (make-aim
          (aim-ufo w)
          (make-tank (tank-loc (aim-tank w))
                     (if (< (tank-vel (aim-tank w)) 0)
                         (tank-vel (aim-tank w))
                         (* -1 (tank-vel (aim-tank w))))))]
        [(string=? "right" ke)
         (make-aim
          (aim-ufo w)
          (make-tank (tank-loc (aim-tank w))
                     (if (> (tank-vel (aim-tank w)) 0)
                         (tank-vel (aim-tank w))
                         (* -1 (tank-vel (aim-tank w))))))]
        [(string=? " " ke)
         (make-fired
          (make-posn (posn-x (aim-ufo w)) (posn-y (aim-ufo w)))
          (make-tank (tank-loc (aim-tank w)) (tank-vel (aim-tank w))) 
          (make-posn (tank-loc (aim-tank w)) (- CANVAS-HEIGHT TANK-HEIGHT)))]
        [else w])
      (cond
        [(string=? "left" ke)
         (make-fired
          (fired-ufo w)
          (make-tank (tank-loc (fired-tank w))
                     (if (< (tank-vel (fired-tank w)) 0)
                         (tank-vel (fired-tank w))
                         (* -1 (tank-vel (fired-tank w)))))
          (fired-missile w))]
        [(string=? "right" ke)
         (make-fired
          (fired-ufo w)
          (make-tank (tank-loc (fired-tank w))
                     (if (> (tank-vel (fired-tank w)) 0)
                         (tank-vel (fired-tank w))
                         (* -1 (tank-vel (fired-tank w)))))
          (fired-missile w))]
        [(string=? " " ke) w]
        [else w])
   ))


(define (si-main w)
  (big-bang w
            [on-tick si-move]
            [to-draw si-render]
            [on-key si-control]
            [stop-when si-game-over?]))

(si-main aim-ex1)
  

