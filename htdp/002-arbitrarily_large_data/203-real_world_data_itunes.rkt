;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 203-real_world_data_itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 203

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
(define TRACK3 (create-track "One" "Metallica" "...and Justice for All" 111111 2 DATE1 633 DATE2))
(define TRACK4 (create-track "Master of Puppets" "Metallica" "Master of Puppets" 111111 2 DATE1 633 (create-date 2017 12 3 23 59 59)))
(define TRACK5 (create-track "Disposable Heroes" "Metallica" "Master of Puppets" 111111 2 DATE1 633 (create-date 2017 12 1 23 41 12)))
(define TRACK6 (create-track "Battery" "Metallica" "Master of Puppets" 111111 2 DATE1 633 (create-date 2017 12 25 23 41 12)))

(define LTRACK1 (list TRACK1 TRACK2))
(define LTRACK2 (list TRACK1 TRACK3 TRACK4 TRACK5 TRACK6))

(check-expect (select-album-date "Master of Puppets" DATE2 LTRACK2 '()) (list TRACK6 TRACK4))
; String Date LTracks -> LTracks
; extracts the LTracks that belong to the given album and have been played after the given date
(define (select-album-date title date ltracks tmp)
  (cond
    [(empty? ltracks) tmp]
    [(and
      (string=? title (track-album (first ltracks)))
      (previous-date? date (track-played (first ltracks))))
     (select-album-date title date (rest ltracks) (cons (first ltracks) tmp))]
    [else
          (select-album-date title date (rest ltracks) tmp)]))

(check-expect (previous-date? DATE1 DATE2) #true)
(check-expect (previous-date? DATE2 DATE1) #false)
; Date Date -> Bool
; Determines whether the first occurs before the second
(define (previous-date? date1 date2)
  (cond
    [(> (date-year date2) (date-year date1))
     #true]
    [(> (date-month date2) (date-month date1))
     #true]
    [(and (= (date-month date2) (date-month date1)) (> (date-day date2) (date-day date1)))
     #true]
    [else
     #false]))