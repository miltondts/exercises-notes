;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 287-abstracting_with_lambda) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 287

(define-struct ir [name price])
; An inventory record (IR) is a structure:
;   (make-ir String Number)

(define IR1 (make-ir "Banana" 0.02))
(define IR2 (make-ir "RG350" 300))
(define IR3 (make-ir "Ficciones" 20))

(define LIST-OF-IR (list IR1 IR2 IR3))
(define LIST-OF-IR1 (list IR2 IR3))

(check-expect (eliminate-exp 10 LIST-OF-IR) (list IR1))
(check-expect (eliminate-exp 20 LIST-OF-IR) (list IR1))
(check-expect (eliminate-exp 21 LIST-OF-IR) (list IR1 IR3))
; Number List-of-IR -> List-of-IR
; produces a list of all those IR whose acquisition price is below ua
(define (eliminate-exp ua lir)
  (filter (lambda (x) (< (ir-price x) ua)) lir))

(check-expect (recall "Banana" LIST-OF-IR) (list IR2 IR3))
; String List-of-IR -> List-of-IR
; Produces a list of inventory records that do not use the name ty.
(define (recall ty lir)
  (filter (lambda (x) (not (string=? ty (ir-name x)))) lir))


(check-expect (selection LIST-OF-IR LIST-OF-IR1) LIST-OF-IR1)
(check-expect (selection LIST-OF-IR1 LIST-OF-IR) LIST-OF-IR1)
; List-of-String List-of-String -> List-of-String
; Selects all elements of the second list that are also on the first
(define (selection los1 los2)
  (filter
   (lambda (x)
     (ormap (lambda (y) (string=? (ir-name y) (ir-name x))) los1))
   los2))

