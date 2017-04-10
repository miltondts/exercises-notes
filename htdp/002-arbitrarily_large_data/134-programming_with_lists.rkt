;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 134-programming_with_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 134

; List-of-names String -> Boolean
; determines whether "Flatt" occurs on alon 
(check-expect (contains? (cons "X" (cons "Y" (cons "Z" '()))) "Flatt")
              #false)
(check-expect (contains? (cons "A" (cons "Flatt" (cons "C" '()))) "Flatt")
              #true)

(define (contains? alon name)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) name)
         (contains? (rest alon) name))]))

(define list-of-names
  (cons "Fagan"
      (cons "Findler"
            (cons "Fisler"
                  (cons "Fanagan"
                        (cons "Flatt"
                              (cons "Felleisen"
                                    (cons "Friedman" '()))))))))

(contains? list-of-names "Findler")