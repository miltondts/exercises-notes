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
