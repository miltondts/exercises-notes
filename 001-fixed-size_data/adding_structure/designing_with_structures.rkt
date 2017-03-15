;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designing_with_structures) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Sample
; Define the data type
(define-struct r3 [x y z])
; A R3 is a structure:
;   (make-r3 Number Number Number)
; (r3-x r) => extract the x-coordinate
; (r3-y r) => extract the y-coordinate
; (r3-z r) => extract the z-coordinate

; Create functional examples
(define ex1 (make-r3 1 2 13))
(define ex2 (make-r3 -1 0 3))
(define ex3 (make-r3 0 0 3))
(define ex4 (make-r3 0 3 0))
(define ex5 (make-r3 3 0 0))
(define ex6 (make-r3 0 0 0))

; Build a template with each selector of the used structure
;(define (r3-distance-to-0 p)
;  (... (r3-x p) ... (r3-y p) ... (r3-z p) ...))

; Define the tests
(check-within (r3-distance-to-0 ex1) (sqrt 174) 1)
(check-within (r3-distance-to-0 ex2) (sqrt 10) 1)
(check-expect (r3-distance-to-0 ex3) 3)
(check-expect (r3-distance-to-0 ex4) 3)
(check-expect (r3-distance-to-0 ex5) 3)
(check-expect (r3-distance-to-0 ex6) 0)

; R3 -> Number
; computes the distance of objects in a 3-dimensional space to the origin.
(define (r3-distance-to-0 p)
  (sqrt
   (+ (sqr (r3-x p))
      (sqr (r3-y p))
      (sqr (r3-z p)))))

; ------------------------------------------------------------------------------
; Exercise 80
(define-struct movie [title director year])
(define (imdb m)
  (... movie-title m ... movie-director m ... movie-director p ...))

(define-struct person [name hair eyes phone])
(define (stalker p)
  (... person-name p ... person-hair p ... person-eyes p ... person-phone p))

(define-struct pet [name number])
(define (mammal p)
  (... pet-name p ... pet-number p ...))

(define-struct CD [artist title price])
(define (spotify cd)
  (... CD-artist cd ... CD-title cd ... CD-price cd ...))

(define-struct sweater [material size color])
(define (cloth s)
  (... sweater-material s ... sweater-size s ... sweater-color s ...))

; ------------------------------------------------------------------------------
; Exercise 81

; Define the data type
(define-struct point-in-time [hours minutes seconds])
; Point-in-time is a structure:
;       (make-point-in-time Number Number Number)

; Create functional examples
(define example1 (make-point-in-time 0 0 0))
(define example2 (make-point-in-time 0 0 59))
(define example3 (make-point-in-time 0 59 0))
(define example4 (make-point-in-time 23 0 0))
(define example5 (make-point-in-time 0 59 59))
(define example6 (make-point-in-time 1 59 0))
(define example7 (make-point-in-time 1 0 30))
(define example8 (make-point-in-time 12 30 2))

; Build a template
;(define (time->seconds time)
;  (... point-in-time-hours time ... point-in-time-minutes time ... point-in-time-seconds time ...))

; Define the tests
(check-expect (time->seconds example1) 0)
(check-expect (time->seconds example2) 59)
(check-expect (time->seconds example3) 3540)
(check-expect (time->seconds example4) 82800)
(check-expect (time->seconds example5) 3599)
(check-expect (time->seconds example6) 7140)
(check-expect (time->seconds example7) 3630)
(check-expect (time->seconds example8) 45002)

; Point-in-time -> Number
; calculate the number of seconds that have passed since midnight
(define (time->seconds time)
  (+ (* 3600 (point-in-time-hours time))
     (* 60 (point-in-time-minutes time))
     (point-in-time-seconds time)))

; ------------------------------------------------------------------------------
; Exercise 82

; 1) Define the data
; 3-letter-word is a structure (make-three-letter-word 1String 1String 1String ))
 (define-struct 3-letter-word [first second third])

; 2) Define signature, purpose statement and a header
; three-letter-word three-letter-word -> three-letter-word
; produces a word that retains the letters if they agree and contains false where
; the letters disagree
; (define (compare-word word1 word2) ...)

; 3) Create functional examples
(define e1 (make-3-letter-word "a" "a" "a"))
(define e2 (make-3-letter-word "b" "a" "a"))
(define e3 (make-3-letter-word "a" "a" "b"))
(define e4 (make-3-letter-word "a" "z" "a"))
(define e5 (make-3-letter-word "r" "e" "d"))


; 4) Build a template
; (define (compare-word word1 word2)
;  (... 3-letter-word-first word1
;   ... 3-letter-word-second word1
;   ... 3-letter-word-third word1
;   ... 3-letter-word-first word2
;   ... 3-letter-word-second word2
;   ... 3-letter-word-third word2
;   ... ))

; 6) Test
(check-expect (compare-word e1 e1) e1)
(check-expect (compare-word e1 e2) (make-3-letter-word #false "a" "a"))
(check-expect (compare-word e1 e3) (make-3-letter-word "a" "a" #false))
(check-expect (compare-word e1 e4) (make-3-letter-word "a" #false "a"))
(check-expect (compare-word e2 e4) (make-3-letter-word #false #false "a"))
(check-expect (compare-word e3 e5) (make-3-letter-word #false #false #false))


; 5) Build the function
(define (compare-word word1 word2)
  (make-3-letter-word 
                       (cond [(string=?  (3-letter-word-first word1)
                                   (3-letter-word-first word2))
                              (3-letter-word-first word1)]
                             [else #false])  
                       (cond [(string=?  (3-letter-word-second word1)
                                   (3-letter-word-second word2))
                              (3-letter-word-second word1)]
                             [else #false]) 
                        (cond [(string=?  (3-letter-word-third word1)
                                   (3-letter-word-third word2))
                              (3-letter-word-third word1)]
                             [else #false])
                       ))

