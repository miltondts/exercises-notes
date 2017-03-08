;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname meaning) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 121
(+ (* (/ 12 8) 2/3)
    (- 20 (sqrt 4)))
; (+ (* 3/2 2/3)
;    (- 20 (sqrt 4)))
; (+ 1 (- 20 (sqrt 4)))
; (+ 1 (- 20 2))
; (+ 1 18)
; 19

(cond
    [(= 0 0) #false]
    [(> 0 1) (string=? "a" "a")]
    [else (= (/ 1 0) 9)])
;(cond
;    [#true #false]
;    [(> 0 1) (string=? "a" "a")]
;    [else (= (/ 1 0) 9)])
; #false

(cond
    [(= 2 0) #false]
    [(> 2 1) (string=? "a" "a")]
    [else (= (/ 1 2) 9)])
; (cond
;    [(> 2 1) (string=? "a" "a")]
;    [else (= (/ 1 2) 9)])
; (cond
;    [#true (string=? "a" "a")]
;    [else (= (/ 1 2) 9)])
; (string=? "a" "a")
; #true

; ------------------------------------------------------------------------------
; Exercise 122
 (define (f x y)
   (+ (* 3 x) (* y y)))

(+ (f 1 2) (f 2 1))
; (+ (+ (* 3 1) (* 2 2)) (f 2 1))
; (+ (+ 3 (* 2 2)) (f 2 1))
; (+ (+ 3 4) (f 2 1))
; (+ 7 (f 2 1))
; (+ 7  (+ (* 3 1) (* 2 2)))
; (+ 7  (+ 3 (* 2 2)))
; (+ 7  (+ 3 4))
; (+ 7  7)
; 14

(f 1 (* 2 3))
; (f 1 6)
; (+ (* 3 1) (* 6 6))
; (+ 3 (* 6 6))
; (+ 3 36)
; 39

(f (f 1 (* 2 3)) 19)
; (f (f 1 6) 19)
; (f (+ (* 3 1) (* 6 6)) 19)
; (f (+ 3 (* 6 6)) 19)
; (f (+ 3 36) 19)
; (f 39 19)
; (+ (* 3 39) (* 19 19))
; (+ 117 (* 19 19))
; (+ 117 361)
; 478