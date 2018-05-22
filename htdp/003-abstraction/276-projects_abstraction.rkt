;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 276-projects_abstraction) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
; Exercise 276
;  --- HEADERS ---
(require 2htdp/batch-io)
(require 2htdp/itunes)

;  --- CONSTANTS ---
(define DATE1 (create-date 2017 5 16 20 30 46))
(define DATE2 (create-date 2017 12 2 23 41 12))

(define TRACK1 (create-track "For whom the bell tolls" "Metallica" "...and Justice for All" 123445 2 DATE1 633 DATE2))
(define TRACK2 (create-track "Black" "Pearl Jam" "Ten" 1235813 9 DATE2 333 DATE1))
(define TRACK3 (create-track "...and Justice for All" "Metallica" "...and Justice for All" 123445 2 DATE1 633 DATE2))
(define TRACK4 (create-track "Blackened" "Metallica" "...and Justice for All" 123445 2 DATE1 633 DATE2))
(define TRACK5 (create-track "Black" "Pearl Jam" "Ten" 1235813 9 DATE2 333 DATE1))

(define LTRACK1 (list TRACK1 TRACK2))
(define LTRACK2 (list TRACK1 TRACK2 TRACK3 TRACK4 TRACK5))

;  --- AUXILARY FUNCTIONS ---
(check-expect (already-in-set? "blah" (list "blah" "blah" "blah")) #true)
(check-expect (already-in-set? "blah" (list "yo" "mamma")) #false)
(check-expect (already-in-set? "mamma" (list "yo" "mamma")) #true)
(check-expect (already-in-set? "yo" '()) #false)
; String List-of String -> Boolean
; Returns true if String is an element of List-of-String
(define (already-in-set? element set)
  (cond
    [(empty? set) #false]
    [(string=? (first set) element) #true]
    [else
     (already-in-set? element (rest set))]
    ))

(check-expect (set-of-albums LTRACK1 '())
              (list "Ten" "...and Justice for All"))
(check-expect (set-of-albums LTRACK2 '())
              (list "Ten" "...and Justice for All"))
; LTracks List-of-Strings -> List-of-Strings
; Get a set of albums from a list of tracks
(define (set-of-albums ltracks acc)
   (cond
    [(empty? ltracks) acc]
    [(already-in-set? (track-album (first ltracks)) acc)
     (set-of-albums (rest ltracks) acc)]
    [else
     (set-of-albums (rest ltracks) (cons (track-album (first ltracks)) acc))]))

;  --- SELECT ALBUM DATE (USING FILTER) ---
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

(check-expect (select-album-date "...and Justice for All" DATE1 LTRACK1)
              (list TRACK1))
(check-expect (select-album-date "Ten" DATE1 LTRACK1)
              '())
(check-expect (select-album-date "For whom the bell tolls" DATE1 LTRACK1)
              '())
(check-expect (select-album-date "For whom the bell tolls" DATE2 '())
              '())
; String Date LTracks -> LTracks
; Extracts the list of tracks from the given album that have been played after the date.
(define (select-album-date album-title date ltracks)
  (local
    (; Track -> Boolean
     ; Checks if a track has been played after Date
     (define (played-after-date? track)
       (if (string=?
            (track-album track)
            album-title)
           (previous-date? date (track-played track))
           #false)))
    (filter played-after-date? ltracks)))

;  --- SELECT ALBUMS (WITH "REDUCE"-MAP-FILTER) ---
(check-expect (select-albums LTRACK1)
              (list (list TRACK1) (list TRACK2)))
(check-expect (select-albums LTRACK2) (list (list TRACK1 TRACK3 TRACK4) (list TRACK2 TRACK5)))
; LTracks -> List-of-LTracks
; Produces a list of LTracks, one per album.
(define (select-albums ltracks)
  (local
    (; String -> LTracks
     ; Creates a list of tracks for the same album
     (define (select-tracks album)
       (local
         (; Track -> Boolean
          ; Check if the track belong to the album
          (define (filter-album track)
            (string=? (track-album track) album)))
         (filter filter-album ltracks))))
    (map
     select-tracks
     (reverse
      (set-of-albums ltracks '())))))