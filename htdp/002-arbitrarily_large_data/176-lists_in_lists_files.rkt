;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 176-lists_in_lists_files) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 176

; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

; A LoN is one of: 
;  – '() 
;  – (cons Number LoN)

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

; Matrix -> LoN
; Produces the first column as a list of numbers

(check-expect (first* mat1) wor1)

(define (first* mat)
  (if (empty? mat)
      '()
      (cons (first (first mat)) (first* (rest mat)))))

; Matrix -> Matrix
; Removes the first column of a matrix

(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))

(define (rest* mat)
  (if (empty? mat)
      '()
      (cons (rest (first mat)) (rest* (rest mat)))))

; Matrix -> Matrix
; transpose the given matrix along the diagonal 
 
(check-expect (transpose mat1) tam1)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

; Stop! Why does transpose ask (empty? (first lln))?
; Because the function iterates the matrix column by column.
; Eventually it will reach a list of all empty lists (i.e. (cons '() (cons '() '())))
