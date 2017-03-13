;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname input_errors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 110

(define MESSAGE "area-of-disk: number expected")

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

(check-error (checked-area-of-disk "my disk") MESSAGE)
(check-error (checked-area-of-disk -1) MESSAGE)
(check-expect (checked-area-of-disk 1) 3.14)
; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (positive? v)) (area-of-disk v)]
    [else (error MESSAGE)]))

; ------------------------------------------------------------------------------
; Exercise 111

(define NOT-POSITIVE "make-vec: input should be only positive numbers")
(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

(check-error (checked-make-vec "my vec" "your vec") NOT-POSITIVE)
(check-error (checked-make-vec -1 1) NOT-POSITIVE)
(check-error (checked-make-vec 1 -1) NOT-POSITIVE)
(check-error (checked-make-vec -1 -1) NOT-POSITIVE)
(check-expect (checked-make-vec 1 1) (make-vec 1 1))
; Any -> Vec
; instantiates a struct of type Vec
(define (checked-make-vec x y)
  (cond
    [(and (number? x) (number? y) (positive? x) (positive? y))
          (make-vec x y)]
    [else (error NOT-POSITIVE)]))

; ------------------------------------------------------------------------------
; Explain the expected answers!
; missile-or-not? only takes #false or a posn as input, any other input value
; is not valid

; Stop! Find the template and take a second look before you read on.
; Any -> ???
;(define (checked-f v)
;  (cond
;    [(number? v) ...]
;    [(boolean? v) ...]
;    [(string? v) ...]
;    [(image? v) ...]
;    [(posn? v) (...(posn-x v) ... (posn-y v) ...)]
;    ...
    ; which selectors are needed in the next clause?
;    [(tank? v) ...]
;    ...))

(check-expect (missile-or-not? #false) #true)
(check-expect (missile-or-not? (make-posn 9 2)) #true)
(check-expect (missile-or-not? "yellow") #false)
(check-expect (missile-or-not? #true) #false)
(check-expect (missile-or-not? 10) #false)
; Exercise 112
; Any -> Boolean
; is a an element of the MissileOrNot collection
(define (missile-or-not? v)
    (or (false? v) (posn? v)))

; ------------------------------------------------------------------------------
; Exercise 113

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])
; Define the structs that take part of the collection
(define-struct vcat [x mood dir])
(define-struct vcham [pos dir mood color])

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game

; Any -> Boolean
; is a an element of the SIGS collection
(define (sigs? invaders)
    (or (aim? invaders) (fired? invaders)))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; Any -> Boolean
; is a an element of the Coordinate collection
(define (coordinate? n)
  (or (negative? n) (positive? n) (posn? n)))

; A VAnimal is either
; – a VCat
; – a VCham

; Any -> Boolean
; is a an element of the VAnimal collection
(define (vanimal? animal)
  (or (vcat? animal) (vcham? animal)))
