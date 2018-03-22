;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 262-local_definitios-add-expressive-power) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 262

; An IMatrix is one of: 
; – ...

(check-expect (identity-line 0 1) (list 1))
(check-expect (identity-line 0 2) (list 1 0))
(check-expect (identity-line 1 3) (list 0 1 0))
(check-expect (identity-line 2 3) (list 0 0 1))
(check-expect (identity-line 2 4) (list 0 0 1 0))

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
  (local (
    ; Number [List-of Numbers] Number -> [List-of [List-of Number]]
    (define (identityM-loop n tmp current)
      (if (= current (sub1 n))
          (cons (identity-line current n) '())
          (cons (identity-line current n) (identityM-loop n tmp (add1 current)))
          )))
  (identityM-loop n '() 0)))


; local definitions enable the interfaces of each function to be more
; intuitive and coherent with original data definition