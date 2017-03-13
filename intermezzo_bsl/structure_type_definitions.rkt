;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname structure_type_definitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 125
; 1. (define-struct oops [])
;     => is not a legal expression because it should have at least one name
;        within the parentheses

; 2. (define-struct child [parents dob date])
;    => is a legal expression since parentes, dob and date are variables and
;       place inside parentheses

; 3. (define-struct (child parents) [dob date])
;    => is not a legal expression because define-struct is not followed by a
;       single variable name

; ------------------------------------------------------------------------------
; Exercise 126

; The expressions that are values are those that fall within the number,
; boolean, string or image collections or is a structure value

; 1. Values => Number Number Number
; 2. Values => Point Number Number
; 3. Values => Number Number Number
; 4. Not a value because the structure is empty
; 5. Values => Number Number Number

; ------------------------------------------------------------------------------
; Exercise 127

; 1. #false
; 2. 3
; 3. 6
; 4. Error (ball-x expects a Ball variable and is given a Posn)
; 5. Error (ball-y expects a Ball variable and is given a Number)