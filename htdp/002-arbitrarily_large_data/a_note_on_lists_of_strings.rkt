;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a_note_on_lists_of_strings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define test1 (cons "tchk" (cons "tchk" (cons "tchk" '()))))
(define test2 '())
(define test3 (cons "yep" '()))

(check-expect (count test1 "tchk") 3)
(check-expect (count test2 "tchk") 0)
(check-expect (count test3 "tchk") 0)
(check-expect (count test3 "yep") 1)
; List-of-strings String -> Number
; determine how ofter s occurs in los
(define (count los s)
  (if (empty? los)
      0
      (+
       (if (equal? (first los) s)
           1
           0)
       (count (rest los) s))))

; btw, I'm guessing (because I didn't test it in my notebook) that this gives
; way to a linearly recursive process.
; I could make this a linearly iterative process by adding a Number to the
; input that would count up the the lenght of the list.

; Order of growth of the number of steps? (again from the top of my head)
; I'm guessing O(n), where n is the size of the list and we need to add
; a new iteration for every extra element of the list

; ------------------------------------------------------------------------------

; Son
(define es '())

; Number Son -> Son
; is x in s
(define (in? x s)
  (member? x s))

; Number Son.L -> Son.L
; remove x from s
(define s1.L
  (cons 1 (cons 1 '())))

(check-expect (set-.L 1 s1.L) es)

; Number Son -> Son
; subtract x from s
(define (set-.L x s)
  (remove-all x s))

; Number Son.R -> Son.R
; remove x from s
(define s1.R
  (cons 1 '()))

(check-expect
 (set-.R 1 s1.R) es)

(define (set-.R x s)
  (remove x s))


(define set123 (cons 2 (cons 3 (cons 1'()))))
(check-satisfied (set-.R 1 set123) not-member-1?)

; Son -> Boolean
; #true if 1 a member of s, #false otherwise
(define (not-member-1? s)
  (not (in? 1 s)))