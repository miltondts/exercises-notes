;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 165-functions_that_produce_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 165

(check-expect (robot? "robot") "r2d2")
(check-expect (robot? "car") "car")
; String -> String
; replaces "robot" with "r2d2"
(define (robot? toy)
  (if (equal? "robot" toy)
      "r2d2"
      toy))

(define ex1 '())
(define ex2 (cons "car" '()))
(define ex3 (cons "car" (cons "robot" '())))

(check-expect (subst-robot ex1) ex1)
(check-expect (subst-robot ex2) ex2)
(check-expect (subst-robot ex3) (cons "car" (cons "r2d2" '())))
; List-of-toys -> List-of-toys
; replaces all occurences of "robot" with "r2d2"
(define (subst-robot lot)
  (if (empty? lot)
      '()
      (cons (robot? (first lot)) (subst-robot (rest lot)))))

(check-expect (substitute? "blah" "bleh" "blah") "bleh")
(check-expect (substitute? "blih" "bloh" "bluh") "bluh")
; String -> String
; replaces an old string with new
(define (substitute? old new str)
  (if (equal? str old)
      new
      str))

(check-expect (substitute "Constantinople" "Istambul" (cons "Athens" (cons "Rome" (cons "Constantinople" '()))))
              (cons "Athens" (cons "Rome" (cons "Istambul" '()))))
(check-expect (substitute "yo" "mama" '()) '())
; String String List-of-strings -> List-of-strings
; substitutes all occurences of old with new
(define (substitute old new los)
  (if (empty? los)
      '()
      (cons (substitute? old new (first los)) (substitute old new (rest los)))))