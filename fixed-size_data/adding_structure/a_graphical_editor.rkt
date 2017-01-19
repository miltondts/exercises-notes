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

(define CANVAS (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))
(define FONT-SIZE 16)
(define FONT-COLOR "black")

(define ex1 (make-editor "hello " "world"))

(check-expect (render ex1) (overlay/align "left" "center"
                                           (beside
                                            (text "hello " 16 "black")
                                            CURSOR
                                            (text "world" 16 "black"))
                                          (empty-scene 200 20)))

; Editor -> Image
; Render the text within an empty scene
(define (render ed)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre ed) FONT-SIZE FONT-COLOR)
                  CURSOR
                  (text (editor-post ed) FONT-SIZE FONT-COLOR))
                 CANVAS))

; ------------------------------------------------------------------------------
; Exercise 84

; Auxiliar functions:
; String -> 1String (function signature)
; extracts the first character from a non-empty String (purpose statement)
; given: "yo mamma", expects: "y" (example illustration)
; given: "foo", expects "f" (example illustration)
(define (string-first str)
  (string-ith str 0)) ; (header/stub)

; String -> 1String (function signature)
; extracts the last character from str (purpose statement)
; given: "yo mamma", expect: "a"
; given: "foo", expect: "0"
(define (string-last str)
  (string-ith str (- (string-length str) 1)))

; String -> String (function signature)
; produces a string like the given one with the last character removed (purpose statement)
; given: "alfie", expect: "alfi"
; given: "santa", expect: "sant"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

; String -> String (function signature)
; produces a string like the given one with the first character removed (purpose statement)
; given: "alfie", expect: "lfie" 
; given: "santa"; expect: "anta"
(define (string-rest str)
  (substring str 1))

; Designing the function:
; Editor KeyEvent -> Editor
; Performs 2 operations:
; - adds a single character KeyEvent to the end of the pre field;
; - deletes the character imediatly to the left of the cursor in case of
; backspace;
; - moves the cursor sideways when ke is "left" or "right;
; And ignores the tab and return characters

; Template:
;(define (edit ed ke)
;  (cond
;    [(= (string-length ke) 1) ...]
;    [(string=? "\b" ke) ...]
;    [(string=? "left" ke) ...]
;    [(string=? "right" ke) ...]
;    ...))

; Examples:
(define ex2 (make-editor "santiago" "path"))
(define ex3 (make-editor "s" "uper"))
(define ex4 (make-editor "" "soup"))
(define ex5 (make-editor "soap" ""))
(define ex6 (make-editor "synt" "h"))

; Tests:
(check-expect (edit ex2 "w") (make-editor "santiagow" "path"))
(check-expect (edit ex2 " ") (make-editor "santiago " "path"))
(check-expect (edit ex2 "\b") (make-editor "santiag" "path"))
(check-expect (edit ex2 "left") (make-editor "santiag" "opath"))
(check-expect (edit ex2 "right") (make-editor "santiagop" "ath"))
(check-expect (edit ex3 "\b") (make-editor "" "uper"))
(check-expect (edit ex3 "left") (make-editor "" "super"))
(check-expect (edit ex4 "\b") (make-editor "" "soup"))
(check-expect (edit ex4 "left") (make-editor "" "soup"))
(check-expect (edit ex4 "right") (make-editor "s" "oup"))
(check-expect (edit ex5 "w") (make-editor "soapw" ""))
(check-expect (edit ex5 "\b") (make-editor "soa" ""))
(check-expect (edit ex5 "left") (make-editor "soa" "p"))
(check-expect (edit ex5 "right") (make-editor "soap" ""))
(check-expect (edit ex6 "w") (make-editor "syntw" "h"))
(check-expect (edit ex6 "\b") (make-editor "syn" "h"))
(check-expect (edit ex6 "right") (make-editor "synth" ""))
(check-expect (edit ex6 "left") (make-editor "syn" "th"))

; Function:
(define (edit ed ke)
  (cond
    [(string=? "\b" ke)
     (cond
     [(= (string-length (editor-pre ed)) 0) ed]
     [else (make-editor (string-remove-last (editor-pre ed)) (editor-post ed))]
     )]
    [(= (string-length ke) 1)
     (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
    [(string=? "left" ke)
     (cond
     [(= (string-length (editor-pre ed)) 0) ed]
     [else (make-editor
            (string-remove-last (editor-pre ed)) (string-append (string-last (editor-pre ed)) (editor-post ed)))]
     )]
    [(string=? "right" ke)
     (cond
     [(= (string-length (editor-post ed)) 0) ed]
     [else (make-editor
            (string-append (editor-pre ed) (string-first (editor-post ed))) (string-rest (editor-post ed)))]
     )]
    ))

; ------------------------------------------------------------------------------
; Exercise 85
(require 2htdp/universe)

(define (run str)
  (big-bang (make-editor str "")
    [to-draw render]
    [on-key edit]))

; ------------------------------------------------------------------------------
; Exercise 86
(define (re-edit ed ke)
  (cond
    [(string=? "\b" ke)
     (cond
     [(= (string-length (editor-pre ed)) 0) ed]
     [else (make-editor (string-remove-last (editor-pre ed)) (editor-post ed))]
     )]
    [(string=? "left" ke)
     (cond
     [(= (string-length (editor-pre ed)) 0) ed]
     [else (make-editor
            (string-remove-last (editor-pre ed)) (string-append (string-last (editor-pre ed)) (editor-post ed)))]
     )]
     [(>= (image-width (text (editor-pre ed) FONT-SIZE FONT-COLOR)) (image-width CANVAS)) ed]
     [(string=? "right" ke)
     (cond
     [(= (string-length (editor-post ed)) 0) ed]
     [else (make-editor
            (string-append (editor-pre ed) (string-first (editor-post ed))) (string-rest (editor-post ed)))]
     )]
     [(= (string-length ke) 1)
     (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]
    ))

(define (re-run str)
  (big-bang (make-editor str "")
    [to-draw render]
    [on-key re-edit]))

; ------------------------------------------------------------------------------
; Exercise 87
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor str index) describes an editor where the entire text
; entered is str and index is the number of characters between the first
; character and the cursor

(define-struct editor2 [str index])

(define (string-delete str i) (string-append (substring str 0 i) (substring str (+ i 1))))

(define example1 (make-editor2 "hello world" 6))
(check-expect (render2 example1) (overlay/align "left" "center"
                                           (beside
                                            (text "hello " 16 "black")
                                            CURSOR
                                            (text "world" 16 "black"))
                                          (empty-scene 200 20)))
; Editor -> Image
; Render the text within an empty scene
(define (render2 ed)
  (overlay/align "left" "center"
                 (beside
                  (text (substring (editor2-str ed) 0 (editor2-index ed)) FONT-SIZE FONT-COLOR)
                  CURSOR
                  (text (substring (editor2-str ed) (editor2-index ed)) FONT-SIZE FONT-COLOR))
                 CANVAS))

;(define example2 (make-editor2 "santiago" 8))
;(define example3 (make-editor2 "super" 1))
;(check-expect (edit2 example2 "\b") (make-editor2 "santiag" 7))
;(check-expect (edit2 example3 "\b") (make-editor2 "uper" 0))

; Editor KeyEvent -> Editor
; Performs 2 operations:
; - adds a single character KeyEvent to the end of the pre field;
; - deletes the character imediatly to the left of the cursor in case of
; backspace;
; - moves the cursor sideways when ke is "left" or "right;
; And ignores the tab and return characters
;(define (edit2 ed ke))