;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 130-creating_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 130
(cons "Oak"
      (cons "Flatt"
            (cons "Krishnamurti"
                  (cons "Felleisen"
                        (cons "Findler" '())))))

; (cons "1" (cons "2" '()) is an element of list-of-names because it respects
;the (cons String List-of-names) data definition, while (cons 2 '()) specifies
;an list with an integer and thus is not a List-of-names