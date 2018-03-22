;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 261-local_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 261

(define-struct ir [name price])
; An IR is a structure:
;   (make-ir String Number)

; An Invetory is on of:
;    - '()
;    - (cons IR '())
(define TEST (list
              (make-ir "filipinos" 3.0)
              (make-ir "donuts" 1.5)
              (make-ir "gorila" 0.5)
              (make-ir "salmon" 10.0)
              (make-ir "hendricks" 30)
              (make-ir "yo mamma" 0.1)
              (make-ir "wine" 3.0)
              (make-ir "water" 1.5)
              (make-ir "beer" 0.5)))

(check-expect (build-test-data (make-ir "filipinos" 3.0) 1) (list (make-ir "filipinos" 3.0)))
(check-expect (build-test-data (make-ir "filipinos" 3.0) 2) (list (make-ir "filipinos" 3.0) (make-ir "filipinos" 3.0)))

(define (build-test-data default n)
  (cond
    [(= n 0) '()]
    [else
     (cons default (build-test-data default (sub1 n)))]))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (ir-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1.v2 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local ((define the-rest (extract1.v2 (rest an-inv))))
     (cond
       [(<= (ir-price (first an-inv)) 1.0)
        (cons (first an-inv) the-rest)]
       [else the-rest]))]))

(check-expect (extract1 TEST) (extract1.v2 TEST))

(define TEST2 (build-test-data (make-ir "filipinos" 3.0) 100000))
(time (extract1 TEST2))
(time (extract1.v2 TEST2))
