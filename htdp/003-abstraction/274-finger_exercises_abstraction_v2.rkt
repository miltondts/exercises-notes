;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 274-finger_exercises_abstraction_v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 274

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a") (list "a" "b")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a") (list "a" "b") (list "a" "b" "c")))

; List-of-1Strings -> List-of-prefixes
; produces the list of all prefixes
(define (prefixes lo1s)
  (local (; Number -> List-of-1String
          ; Get all elements of list up to index n
          (define (get-prefix n)
            (get-prefixes n lo1s '())))
  (build-list (length lo1s) get-prefix)))

;TODO: Optimization -> Instead of reversing in the end, collect the indexes reversly
(check-expect (get-prefixes 0 (list "a" "b" "c") '()) (list "a"))
(check-expect (get-prefixes 1 (list "a" "b" "c") '()) (list "a" "b"))
(check-expect (get-prefixes 2 (list "a" "b" "c") '()) (list "a" "b" "c"))
; Number List-of-1String -> List-of-1String
; Get all elements of list up to index n
(define (get-prefixes n lo1s result)
  (cond
    [(= n -1) (reverse result)]
    [else
     (get-prefixes (sub1 n) (rest lo1s) (cons (first lo1s) result))]))


(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "b") (list "a" "b")))
(check-expect (suffixes (list "a" "b" "c")) (list (list "c") (list "b" "c") (list "a" "b" "c")))

; List-of-1Strings -> List-of-suffixes
; produces the list of all prefixes
(define (suffixes lo1s)
  (local (; Number -> List-of-1String
          ; Get all elements of list up to index n
          (define (get-prefix n)
            (reverse (get-prefixes n (reverse lo1s) '()))))
  (build-list (length lo1s) get-prefix)))
