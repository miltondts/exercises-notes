;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname computing_with_structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 69
; ---------
;|  movie  |
; ---------
; ---------  ----------  ---------
;|  title  || producer ||  year   |
; ---------  ----------  ---------


; ---------
;| person  |
; ---------
; ---------  ---------  ---------  ---------
;|   name  ||   hair  ||   eyes  ||  phone  |
; ---------  ---------  ---------  ---------


; ---------
;|   pet   |
; ---------
; ---------  ---------
;|   name  ||  number |
; ---------  ---------


; ---------
;|   CD    |
; ---------
; ---------  ---------  ---------
;|  artist ||  title  ||  price  |
; ---------  ---------  ---------


; ---------
;| sweater |
; ---------
; ----------  ---------  ----------
;| material ||   size  || producer |
; ----------  ---------  ----------

; ------------------------------------------------------------------------------
; Stop! Try this last interaction at home, so you see the proper result.
;(make-centry "Shriram Fisler"
;             (make-phone 207 "363-2421")
;             (make-phone 101 "776-1099")
;             (make-phone 208 "112-9981"))
;
;(make-centry "Shriram Fisler" (make-phone 207 "363-2421") (make-phone 101 "776-1099") (make-phone 208 "112-9981"))

; ------------------------------------------------------------------------------
; Exercise 70
(define-struct centry [name home office cell])
 
(define-struct phone [area number])
 
(make-centry "Shriram Fisler"
             (make-phone 207 "363-2421")
             (make-phone 101 "776-1099")
             (make-phone 208 "112-9981"))

; (define-struct centry [name home office cell])
; (centry-name (make-centry name home office cell)) == name
; (centry-home (make-centry name home office cell)) == home
; (centry-office (make-centry name home office cell)) == office
; (centry-cell (make-centry name home office cell)) == cell

; (define-struct phone [area number])
; (phone-area (make-phone area number)) == area
; (phone-number (make-phone area number)) == number

; To find "101" DrRacket performs:
; (centry-office
;  (make-centry
;    "Shriram Fisler"
;    (make-phone 207 "363-2421")
;    (make-phone 101 "776-1099")   
;    (make-phone 208 "112-9981")))
; Returning (make-phone 101 "776-1099")
; And then:
; (phone-area
;  (make-phone 101 "776-1099"))
; Ending up with:
; 101

; ------------------------------------------------------------------------------
; Exercise 71
; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

; (game-ball game0)
; => (game-ball (make-game 100 100 (make-posn 200 200)))
; => (make-posn 200 200)

; (posn? (game-ball game0))
; => (posn? (make-posn 200 200))
; => #true

; (game-left-player game0)
; => (game-left-player (make-game 100 100 (make-posn 200 200)))
; => 100