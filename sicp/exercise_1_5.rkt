#lang scheme

(define (p) (p)) ; => what does this mean?

(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))

; applicative-order evaluation => evaluate the arguments and then apply
; (test 0 (p)) => infinite loop because it can't expand (p)

; normal-order evaluation => fully expand and then reduce
; (if (= 0 0) 0 (p)) => The returned result is 0

; I believe the racket interpreter uses applicative-order evaluation, because
; when it tries to evaluate the second argument it freezes