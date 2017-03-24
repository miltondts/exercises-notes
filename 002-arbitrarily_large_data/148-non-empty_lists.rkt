;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 148-non-empty_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 148
; In my opinion, it is better to work with definitions of non-empty list.
; NELists do not ignore the value of '(), they simply compute results based
; on all the values that are not '().
; '() symbolizes that no value has already been added to the list, that all
; values have been removed or even that we have reached the end of the list,
; and all these inputs are valueable when handling a list of values. '() is
; not a value in itself.