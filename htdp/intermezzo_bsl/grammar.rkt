;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname grammar) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 116
; x is a variable, and thus is a valid expression
; expr = variable

; (= y z) is a primitive application, given = is a primitive and y and z are
; variables, and  respects the sintactic order given that it is formed by "("
; followed by an expression and terminated with ")"
; expr = (primitive expr expr ...)

; (= (= y z) 0) is a primitive applicattion, given = is a primitive, followed by
; the previously stated primitive and a variable, all within parenthesis
; expr = (primitive expr expr ...)

; ------------------------------------------------------------------------------
; Exercise 117
; (3 + 4) is sintactically illegal because the primitive is between the two
; variables instead before them (after the left parenthesis)

; number? is sintactically illegal because it has no parenthesis nor value
; associated

; (x) is sintactically illegal because x is a variable and the parenthesis
; imply a function

; ------------------------------------------------------------------------------
; Exercise 118
; (define (f x) x) 
; (define (f x) y)
; (define (f x y) 3)
; are all valid sintactically because they are all formed by a "(", followed by
; the keyword define, followed by another "(" followed by a sequence of at least
; 2 variables, followed by a ")" followed by a valid expression, i.e. a variable,
; and terminated with a ")"
; def = ((define variable variable ...) expr)

; ------------------------------------------------------------------------------
; Exercise 119
; (define (f "x") x) => illegal because "x" is not a variable

; (define (f x y z) (x)) => illegal because (x) is not a valid expression

; ------------------------------------------------------------------------------
; Exercise 120
; (x) => illegal => def = ((define variable variable ...) expr)
; (+ 1 (not x)) => legal => expr = (primitive expr expr ...)
; (+ 1 2 3) => legal => expr = (primitive expr expr ...)
