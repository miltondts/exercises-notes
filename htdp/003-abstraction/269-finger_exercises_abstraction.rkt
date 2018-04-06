;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 269-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 269

; [X] [X -> Boolean] [List-of X] -> [List-of X]
; produces a list from those items on lx for which p holds 
; (define (filter p lx) ...)

(define-struct ir [name description a-price s-price])
; An IR is a structure:
;   (make-ir String String Number Number)

(define IBANEZ (make-ir "ibanez" "guitar" 500 1000))
(define GIBSON (make-ir "gibson" "guitar" 100 500))
(define MAHALO (make-ir "mahalo" "ukulele" 5 20))


(check-expect (eliminate-expensive 500 (list IBANEZ)) '())
(check-expect (eliminate-expensive 250 (list MAHALO)) (list MAHALO))
(check-expect (eliminate-expensive 750 (list MAHALO IBANEZ GIBSON)) (list MAHALO GIBSON))

; Number List-of-IR -> List-of-IR
; produces a list of all items whose sales price is below ua
(define (eliminate-expensive ua inventory)
  (local (; IR -> Boolean
          ; validate if an IR sales price is not an expense
          (define (cheap? ir)
            (< (ir-s-price ir) ua)))
    (filter cheap? inventory)))


(check-expect (recall "gibson" (list GIBSON IBANEZ)) (list IBANEZ))
(check-expect (recall "gibson" (list GIBSON)) '())
; String List-of-IR -> List-of-IR
; produces a list of inventory records that do not use the name ty
(define (recall ty inventory)
  (local (; IR -> Boolean
          ; validate if name of record is different from ty
          (define (diff-name? ir)
            (not (string=? (ir-name ir) ty))))
    (filter diff-name? inventory)))

(check-expect (str-in-list? "ibanez" (list "ibanez" "gibson")) #true)
(check-expect (str-in-list? "mahalo" (list "ibanez" "gibson")) #false) 
; String List-of-String -> Boolean
; Checks if a string exists in a list of strings
(define (str-in-list? str los)
  (cond
    [(empty? los) #false]
    [(string=? str (first los)) #true]
    [else
     (str-in-list? str (rest los))]))

(check-expect (selection (list "ibanez" "gibson" "mahalo") (list "gibson" "mahalo")) (list "gibson" "mahalo"))
(check-expect (selection (list "ibanez" "gibson") (list "gibson")) (list "gibson"))
(check-expect (selection (list "ibanez") (list "mahalo")) '())
; List-of-String List-of-String -> List-of-String
; selects all those from the second one that are also on the first
(define (selection first-los second-los)
  (local
    (; String -> Boolean
     ; check if a name is in a list
     (define (name-in-list? name)
       (str-in-list? name second-los)))
    (filter name-in-list? first-los)))