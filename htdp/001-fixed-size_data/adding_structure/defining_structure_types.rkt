;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname defining_structure_types) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 65
(define-struct movie [title producer year])
; constructor: make-movie
; selector: movie-title movie-producer movie-year
; predicate: movie?

(define-struct person [name hair eyes phone])
; constructor: make-person
; selector: person-name person-hair person-eyes person-phone
; predicate: person?

(define-struct pet [name number])
; constructor: make-pet
; selector: pet-name pet-number
; predicate: pet?

(define-struct CD [artist title price])
; constructor: make-CD
; selector: CD-artist CD-title CD-price
; predicate: CD?

(define-struct sweater [material size producer])
; constructor: make-sweater
; selector: sweater-material sweater-size sweater-producer
; predicate: sweater?

; Exercise 66
(make-movie "Inception" "Christopher Nolan" 2009)
(make-person "Me" "brown" "brown" "555-0789")
(make-pet "Mastodon" 2)
(make-CD "Eric Clapton" "From the cradle" 5)
(make-sweater "cotton" "M" "Zara")

; Exercise 67
(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")

; structure balld takes as inputs the distance of the ball from the top of the
; canvas (location) and the direction it is moving in ("up", "down", "left",
; "right.
; the SPEED of the motion is set as a constant 3 pixels per clock tick
; e.g.
(make-balld 22 "down")

; Exercise 68
(define-struct ballf [x y deltax deltay]) ;  flat representation
(make-ballf 30 40 -10 5)