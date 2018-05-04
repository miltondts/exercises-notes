;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 274-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 274

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
; constructs a list by applying f to each item on lx
; (map f (list x-1 ... x-n)) == (list (f x-1) ... (f x-n))
;(define (map f lx) ...)

;[1String List-of-1String] [] [List-of 1String] [List-of- List-of-1String]

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a") (list "b" "a")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a") (list "b" "a") (list "c" "b" "a")))
; List-of-1Strings -> List-of-prefixes
; produces the list of all prefixes
(define (prefixes lo1s)
  (local (; 1String -> List-of-1String
          ; Returns all elements of lo1s up to 1String
          (define (up-to-1s 1s)
            (get-them-up-to-1s 1s lo1s '())))
  (map up-to-1s lo1s)))


; Note, won't work for (list "a" "a" "b")
(check-expect (get-them-up-to-1s "a" '() '()) '())
(check-expect (get-them-up-to-1s "a" (list "a" "b") '()) (list "a"))
(check-expect (get-them-up-to-1s "b" (list "a" "b") '()) (list "b" "a"))
; 1String List-of-1String -> List-of-1String
; Returns all elements of lo1s up to 1String
(define (get-them-up-to-1s 1s lo1s result)
  (cond
    [(empty? lo1s) result]
    [(string=? (first lo1s) 1s)
     (cons (first lo1s) result)]
    [else
     (get-them-up-to-1s 1s (rest lo1s) (cons (first lo1s) result)) ]))