;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname itemizations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 53
; A LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight

; QUESTION. When they say "draw" world scenarios do they mean:
; - draw data examples with pen and paper?
; - draw data examples using drRacket?
; - specify examples of the previously defined itemization?

; Assuming the 3rd option:
; interpretation “height” refers to the distance between the
; top of the canvas and the reference point
; Examples:
; for height = HEIGHT, the rocket's reference point will be on the ground
; for height = 0, the rocket's reference point will be on the
; top edge of the canvas

; -------------------------------------------------------------------
; Exercise 54
; (string=? "resting" x) incorrect because if x is an Number the program
; will fail and exit with error (string=?: expects a string as 1st argument, given x)

; When x belongs to the first subclass of LRCD:
; [(string? x) (cond [(string=? "resting" x) ...]]

; -------------------------------------------------------------------
; Exercise 55
; (define (place-rocket x y) (place-image ROCKET x (- y CENTER) BACKG))
; Why is this a good ideia? 
; If we only need to define the function once, any alteration it requires also only
; has to be performed on one spot which makes it less prone to propagating errors.
; This also makes the code more readable and easier to understand (because the function has
; the same meaning in every context)

; -------------------------------------------------------------------
; A LRCD (for launching rocket count down) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in count-down mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

(require (lib "2htdp/universe"))
(require (lib "2htdp/image"))

; Constants
(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

; Number Number -> Image
; place the center of the ROCKET x pixels from the left
;  and y pixels from the top of the canvas
(define (place-rocket x y) (place-image ROCKET x (- y CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))
(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))

; LRCD -> Image
; renders the state as a resting or flying rocket 
(define (show x)
  (cond
    [(and (string? x) (string=? x "resting"))
     (place-rocket 10 HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket 10 HEIGHT))]
    [(>= x 0)
     (place-rocket 10 x)]))

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)
 
; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
    [to-draw show]
    [on-key launch]))

; LRCD -> Bool
(define (end? s) (and (number? s) (= s 0)))

; Exercise 56
; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-key launch]
    [on-tick fly]
    [stop-when end?]))

; When the rocket reaches the top the simulation
; goes back to the beggining of the countdown
; because x is returned by fly as negative number (-3)
; which fall whithin the second launch condition

;-------------------------------------------------------------------
; Exercise 57
; interpretation “height” refers to the distance between the
; the ground and the rocket's reference point

; Number Number -> Image
; place the center of the ROCKET x pixels from the left
;  and y pixels from the ground of the canvas
(define (place-rocket2 x y) (place-image ROCKET x (- HEIGHT (+ y CENTER)) BACKG))

; LRCD -> Image
; renders the state as a resting or flying rocket 
(define (show2 x)
  (cond
    [(and (string? x) (string=? x "resting"))
     (place-rocket2 10 0)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket2 10 0))]
    [(>= x 0)
     (place-rocket2 10 x)]))

; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already
(define (fly2 x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) 0 (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

; LRCD -> Bool
(define (end2? s) (and (number? s) (= s (+ HEIGHT CENTER))))

; Exercise 56
; LRCD -> LRCD
(define (main3 s)
  (big-bang s
    [to-draw show2]
    [on-key launch]
    [on-tick fly2]
    [stop-when end2?]))