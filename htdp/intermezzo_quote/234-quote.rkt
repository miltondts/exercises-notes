;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 234-quote) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 234

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

; List-of-strings -> List-of-ranked-strings
; Get ordered list of rankings
(define (ranking los)
  (reverse (add-ranks (reverse los))))

; List-of-strings -> List-of-ranked-strings
; Compute the rankings of a LoS
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))


; List-of-ranked-song-titles -> List-of-HTML-rows
(define (make-row lorst)
  (if (empty? lorst)
      '()
      `((tr
        (td ,(number->string (first (first lorst))))
        (td ,(rest (first lorst))))
        ,(make-row (rest lorst)))))

(check-expect
 (make-ranking (ranking one-list))
 (list
 'html
 (list
  'body
  (list
   'table
   (list (list 'border "1"))
   (list 'tr (list 'td "1") (list 'td (list "Asia: Heat of the Moment")))
   (list 'tr (list 'td "2") (list 'td (list "U2: One")))
   (list 'tr (list 'td "3") (list 'td (list "The White Stripes: Seven Nation Army")))))))

; List-of-ranked-song-titles -> List-HTML-table
; Produce an HTML table of ranked song titles
(define (make-ranking lorst)
   `(html
     (body
      (table ((border "1"))
             (tr (td ,(number->string (first (first lorst))))
                 (td ,(rest (first lorst))))
             (tr (td ,(number->string (first  (second lorst))))
                 (td ,(rest (second lorst))))
             (tr (td ,(number->string (first (third lorst))))
                 (td ,(rest (third lorst))))
                 ))))