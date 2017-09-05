;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 170-structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 170

(define-struct phone [area switch four])
; Phone is a structure:
;     (make-phone Three Three Four)
; Three is a number between 100 and 999
; Four is a number between 1000 and 9999

(define ex1 (make-phone 555 178 1234))
(define ex2 (make-phone 713 555 2999))
(define ex3 (make-phone 713 234 2299))
(define ex4 (make-phone 259 324 5000))
(define ex6 (cons ex1 '()))
(define ex7 (cons ex2 '()))
(define ex8 (cons ex1 (cons ex2 (cons ex3 (cons ex4 '())))))

(check-expect (occured? ex1) #false)
(check-expect (occured? ex2) #true)
(check-expect (area-281 ex2) (make-phone 281 555 2999))
(check-expect (replace '()) '())
(check-expect (replace ex6) ex6)
(check-expect (replace ex7) (cons (make-phone 281 555 2999) '()))
(check-expect (replace ex8) (cons ex1 (cons (make-phone 281 555 2999) (cons (make-phone 281 234 2299) (cons ex4'()))))) 


; Validate if the area code is 713
; Phone -> predicate
(define (occured? p)
  (= (phone-area p) 713))

; Replaces a phone's area core with 281
(define (area-281 p)
  (make-phone 281 (phone-switch p) (phone-four p)))

; Replaces all occurences of area code 713 with 281
; List-of-phone -> List-of-phone
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [(occured? (first lop)) (cons (area-281 (first lop)) (replace (rest lop)))]
    [else
     (cons (first lop) (replace (rest lop)))]))