;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname a_graphical_editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Exercise 83
(require 2htdp/image)

(define BKGN (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))
(define FONT-SIZE 11)
(define FONT-COLOR "black")

(define ex1 (make-editor "hello " "world"))

(check-expect (render ex1) (overlay/align "left" "center"
                                           (beside
                                            (text "hello " 11 "black")
                                            CURSOR
                                            (text "world" 11 "black"))
                                          (empty-scene 200 20)))

; Editor -> Image
; Render the text within an empty scene
(define (render ed)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre ed) FONT-SIZE FONT-COLOR)
                  CURSOR
                  (text (editor-post ed) FONT-SIZE FONT-COLOR))
                 BKGN))
