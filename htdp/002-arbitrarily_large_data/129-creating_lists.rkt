;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 129-creating_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 129
; 1. List of celestial bodies
(cons "Neptune"
      (cons "Uranus"
            (cons "Saturn"
                  (cons "Jupiter"
                        (cons "Mars"
                              (cons "Earth"
                                    (cons "Venus"
                                          (cons "Mercury" '()))))))))

; 2. List of items for a meal
(cons "ice cream"
      (cons "brie cheese"
            (cons "beans"
                  (cons "water"
                        (cons "french fries"
                              (cons "steak" '()))))))

; 3. List of colors
(cons "orange"
      (cons "purple"
            (cons "yellow"
                  (cons "green"
                        (cons "blue"
                              (cons "red" '()))))))

; I like better the sketches from figure 44
