#lang scheme

(define (count-change amount) (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1)) (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 10)
(count-change 11)


; The orders of growth of space used by this process as the amount increases
;are O(n). The process is linearly recursive and thus only needs to store the
;information on the preceding nodes. Thus, thee space required increases with
;the depth of the tree.

; However, the computation requires O(n^k) steps, being k the number of kinds
;of coins available.
; With a single kind of coin (1 cent), the process to compute the amount 11,
;requires 23 steps (2*n + 1)
; With two coins (1 and 5 cents), n/5 of the steps require the use of the
;second kind of coin, given us (n/5)*(2*n) + 1 => O(n^2)
; And so on.
; This linearly recursive process implies a lot of redundant calculations.


;Note:
; When drawing a tree illustrating the recursive process, each node gives way to
;a number of nodes equal to the number of recursive calls in the function.
; For example, for (+ (fib (- n 1)) (fib (- n 2))) each node will have 2
;children one for (fib (- n 1)) and one for (fib (- n 2))
                                  











