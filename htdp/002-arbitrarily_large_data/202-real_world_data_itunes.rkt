;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 202-real_world_data_itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 202

(require 2htdp/batch-io)
(require 2htdp/itunes)

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

(define DATE1 (create-date 2017 5 16 20 30 46))
(define DATE2 (create-date 2017 12 2 23 41 12))

(define TRACK1 (create-track "For whom the bell tolls" "Metallica" "...and Justice for All" 111111 2 DATE1 633 DATE2))
(define TRACK2 (create-track "Black" "Pearl Jam" "Ten" 222222 9 DATE2 333 DATE1))
(define TRACK3 (create-track "One" "Metallica" "...and Justice for All" 111111 2 DATE1 633 DATE2))

(define LTRACK1 (list TRACK1 TRACK2))

(check-expect (total-time LTRACK1 0) 333333)
; Track Number -> Number
; produces the total amount of play time.
(define (total-time track-list total)
  (if (empty? track-list)
      total
      (total-time (rest track-list) (+ total (track-time (first track-list))))))

(check-expect (select-all-album-titles LTRACK1 '()) (list "Ten" "...and Justice for All"))
; LTracks List-of-strings -> List-of-strings
; produces the list of album titles
(define (select-all-album-titles track-list list-of-titles)
  (if (empty? track-list)
      list-of-titles
     (select-all-album-titles
      (rest track-list)
      (cons (track-album (first track-list)) list-of-titles))))

(check-expect (create-set (list "blah" "bleh" "blah") '()) (list "bleh" "blah"))
(check-expect (create-set (list "ya" "yo") '()) (list "yo" "ya"))
; List-of-strings List-of-strings -> List-of-strings
; removes repeated entries 
(define (create-set list tmp)
  (cond
   [(empty? list) tmp]
   [(member? (first list) tmp)
    (create-set (rest list) tmp)]
   [else
    (create-set (rest list) (cons (first list) tmp))]))

(check-expect (select-album-titles/unique (cons TRACK1 LTRACK1)) (list "...and Justice for All" "Ten"))
; LTracks -> LTracks
; creates a list of unique album titles
(define (select-album-titles/unique track-list)
  (create-set (select-all-album-titles track-list '()) '()))

(check-expect (select-album "...and Justice for All" (list TRACK1 TRACK2 TRACK3) '()) (list TRACK3 TRACK1))
; String LTracks LTracks -> LTracks
(define (select-album album track-list album-track-list)
  (cond
    [(empty? track-list) album-track-list]
    [(string=? album (track-album (first track-list)))
     (select-album album (rest track-list) (cons (first track-list) album-track-list))]
    [else
     (select-album album (rest track-list) album-track-list)]))