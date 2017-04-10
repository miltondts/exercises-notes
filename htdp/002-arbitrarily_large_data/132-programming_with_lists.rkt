;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 132-programming_with_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 132
; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon 
(check-expect (contains-flatt? (cons "X" (cons "Y" (cons "Z" '()))))
              #false)
(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))

(define list-of-names
  (cons "Fagan"
      (cons "Findler"
            (cons "Fisler"
                  (cons "Fanagan"
                        (cons "Flatt"
                              (cons "Felleisen"
                                    (cons "Friedman" '()))))))))

(contains-flatt? list-of-names) ; I expect the result to be true
