;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 268-finger_exercises_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 268

; An inventory record specifies the name of an item, a description,
; the acquisition price, and the recommended sales price.

(define-struct ir [name description a-price s-price])
; An IR is a structure:
;   (make-ir String String Number Number)

; [X] [List-of X] [X X -> Boolean] -> [List-of X]
; produces a version of lx that is sorted according to cmp
;(define (sort lx cmp) ...)


(define BANANA (make-ir "bananas" "fruit" 0.2 0.6))
(define KIWI (make-ir "kiwi" "fruit" 0.1 0.6))

(check-expect (sort-inventory (list BANANA))
              (list BANANA))

(check-expect (sort-inventory
               (list BANANA KIWI))
              (list KIWI BANANA))
; List-of-IR -> List-of-IR
; sorts a list of inventory records by the difference between the two prices
(define (sort-inventory inventory)
  (local
    (; IR IR -> Boolean
     ; sorts two inventory records
     (define (sort-record rec1 rec2)
       (> (- (ir-s-price rec1) (ir-a-price rec1))
          (- (ir-s-price rec2) (ir-a-price rec2)))))
    (sort inventory sort-record)))