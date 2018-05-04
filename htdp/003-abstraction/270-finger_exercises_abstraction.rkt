;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 270-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 270

; [X] N [N -> X] -> [List-of X]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
; (build-list n f) == (list (f 0) ... (f (- n 1)))
;(define (build-list n f) ...)

(check-expect (build-list-1 9) (list 0 1 2 3 4 5 6 7 8))
; Number -> [List-of Number]
; creates the list (list 0 ... (- n 1)) for any natural number n
(define (build-list-1 n)
  (local
    ((define (f n)
      n))
  (build-list n f)))

(check-expect (build-list-2 9) (list 1 2 3 4 5 6 7 8 9))
; Number -> [List-of Number]
; creates the list (list 1 ... n) for any natural number n;
(define (build-list-2 n)
  (local
    ((define (f n)
      (+ 1 n)))
  (build-list n f)))

(check-expect (build-list-3 3) (list 1 (/ 1 2) (/ 1 3)))
; Number -> [List-of Number]
; creates the list (list 1 1/2 ... 1/n) for any natural number n
(define (build-list-3 n)
  (local
    ((define (f n)
      (/ 1 (+ n 1))))
  (build-list n f)))

(check-expect (build-list-4 3) (list 2 4 6))
; Number -> [List-of Number]
; creates the list of the first n even numbers;
(define (build-list-4 n)
  (local
    ((define (f n)
      (* 2 (+ n 1))))
  (build-list n f)))

; Number Number -> [List-of Number]
; creates line of 0s and a single 1
(define (identity-line column size)
  (local (
          ; Number Number [List-of Number] Number -> [List-of Number]
          (define (identity-line-loop column size tmp current)
            (cond
              [(= current size) tmp]
              [(= current column) (cons 1 (identity-line-loop column size tmp (add1 current)))]
              [else
               (cons 0 (identity-line-loop column size tmp (add1 current)))])))
    (identity-line-loop column size '() 0)))

(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
; Number -> [List-of [List-of Number]]
; creates diagonal squares of 0s and 1s
(define (identityM n)
  (local
    ((define (f column)
       (identity-line column n)))
    (build-list n f)))

(check-expect (tabulate sqr 2) (list 0 1))
; Number -> [List-of [List-of Number]]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
(define (tabulate f n)
  (build-list n f))
