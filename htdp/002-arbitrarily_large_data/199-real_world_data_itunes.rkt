;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 199-real_world_data_itunes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 199

(require 2htdp/batch-io)
(require 2htdp/itunes)

; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))

(define DATE1 (create-date 2017 5 16 20 30 46))
(define DATE2 (create-date 2017 12 2 23 41 12))

(define TRACK1 (create-track "For whom the bell tolls" "Metallica" "...and Justice for All" 123445 2 DATE1 633 DATE2))
(define TRACK2 (create-track "Black" "Pearl Jam" "Ten" 1235813 9 DATE2 333 DATE1))

(define LTRACK1 (list TRACK1 TRACK2))