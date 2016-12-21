;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname programs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 31
(require 2htdp/batch-io)
 
(define (opening fst)
  (string-append "Dear " fst ","))
 
(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))
 
(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))

(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

;Create the appropriate files
(define fst (write-file "fst.txt" "Yoggi"))
(define lst (write-file "lst.txt" "Bear"))
(define signature (write-file "signature.txt" "Park Ranger"))

;Launch main
(main fst lst signature 'stdout)
;Result: The output seems fine.

;excersise 32 
;Assuming they are only refering to built-in bio computers 
;1) Heartbeats
;2) Pressure on the skin
;3) Heat on the skin
;4) Changes in blood pressure
;5) Smell
;6) Balance changes
;7) Light 
;8) Taste
;9) Hydration 
;10) Sound

;Studying the big-bang
(require 2htdp/image)
(require 2htdp/universe)

(define (number->square s)
  (square s "solid" "red"))

(define (reset s ke)
  100)

;(big-bang 100 [to-draw number->square])
(big-bang 100
    [to-draw number->square]  ;render the image
    [on-tick sub1]            ;everytime a clock ticks subtract 1 
    [stop-when zero?]         ;check if it is 0 and, if not, continue
    [on-key reset])           ;react to a key event with the reset function => The square will return to its original size everytime I press a key

;Stop! How does big-bang display each of these three states?
;render turns the current state into an image, the exact display will depend on how the input function deal with a given event
;(e.g. if a user presses "a" a text editor should present/print "a" on the sheet)
;In other words, after each event is processed, big-bang uses render to check the current state
