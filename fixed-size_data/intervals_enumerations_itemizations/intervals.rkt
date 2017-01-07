;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname intervals) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Figure 21
; -> This sample had quite a few errors
; - The scene was being printe with the UFO so you have 2 empty scenes overlaying each other (one of them moving)
; - The last line had MT instead of MTSCN
(require (lib "2htdp/universe"))
(require (lib "2htdp/image"))
 
; A WorldState is a Number.
; interpretation number of pixels between the top and the UFO
 
(define WIDTH 300) ; distances in terms of pixels 
(define HEIGHT 100)
(define CLOSE (/ HEIGHT 3))
(define MTSCN (empty-scene WIDTH HEIGHT))
(define UFO (circle 10 "solid" "green"))
 
; WorldState -> WorldState
(define (main y0)
  (big-bang y0
            [on-tick nxt]
            [to-draw render/status]))

 
; WorldState -> WorldState
; computes next location of UFO 
(check-expect (nxt 11) 14)
(define (nxt y)
  (+ y 3))
 
; WorldState -> Image
; place UFO at given height into the center of MTSCN
(check-expect (render 11) (place-image UFO (/ WIDTH 2) 11 MTSCN))
(define (render y)
  (place-image UFO (/ WIDTH 2) y MTSCN))

; WorldState -> Image
; adds a status line to the scene create by render  
(check-expect (render/status 42)
              (place-image (text "closing in" 11 "orange")
                           20 20
                           (render 42)))
 
(define (render/status y)
  (place-image
    (cond
      [(<= 0 y CLOSE)
       (text "descending" 11 "green")]
      [(and (< CLOSE y) (<= y HEIGHT))
       (text "closing in" 11 "orange")]
      [(> y HEIGHT)
       (text "landed" 11 "red")])
    20 20
    (render y)))

; Exercise 52
; [3,5] contains 3, 4 and 5
; (3,5] contains 4 and 5
; [3,5) contains 3 and 4
; (3,5) contains 4

