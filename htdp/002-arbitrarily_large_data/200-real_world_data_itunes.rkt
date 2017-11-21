;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 200-real_world_data_itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 200

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

(define LTRACK1 (list TRACK1 TRACK2))

(check-expect (total-time LTRACK1 0) 333333)
; Track Number -> Number
; produces the total amount of play time.
(define (total-time track-list total)
  (if (empty? track-list)
      total
      (total-time (rest track-list) (+ total (track-time (first track-list))))))