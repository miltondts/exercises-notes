;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 286-abstracting_with_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 286

(define-struct ir [name description a-price s-price])
; An inventory record (IR) is a structure:
;   (make-ir String String Number Number)

(define IR1 (make-ir "Banana" "It's a fruit" 0.01 0.02))
(define IR2 (make-ir "RG350" "It's a guitar" 200 300))
(define IR3 (make-ir "Ficciones" "It's a book" 19 20))

(define LIST-OF-IR (list IR1 IR2 IR3))

(check-expect (revenue IR1) 0.01)
; IR -> Number
; Calculates the difference between acquisition and sales prices
(define (revenue ir)
  ((lambda (x) (- (ir-s-price x) (ir-a-price x))) ir))

(check-expect (sort-inventory LIST-OF-IR) (list IR2 IR3 IR1))
; List-of-IR -> List-of-IR
; sorts a list of inventory records by revenue
(define (sort-inventory loir)
  (sort loir (lambda (x y) (> (revenue x) (revenue y)))))
