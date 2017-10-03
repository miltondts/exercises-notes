;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 179-a_graphical_editor_revisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 179

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)


(check-expect
 (editor-lft
  (make-editor '() (cons "a" (cons "b" '()))))
 (make-editor '() (cons "a" (cons "b" '()))))

(check-expect
 (editor-lft
  (make-editor (cons "d" '()) (cons "f" (cons "g" '()))))
 (make-editor '() (cons "d" (cons "f" (cons "g" '())))))

(check-expect
 (editor-lft
  (make-editor (cons "d" (cons "a" '())) (cons "f" (cons "g" '()))))
 (make-editor (cons "a" '()) (cons "d" (cons "f" (cons "g" '())))))

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible 
(define (editor-lft ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor
       (rest (editor-pre ed))
       (cons (first (editor-pre ed)) (editor-post ed)))))


(check-expect
 (editor-rgt
  (make-editor '() (cons "a" (cons "b" '()))))
 (make-editor (cons "a" '()) (cons "b" '())))

(check-expect
 (editor-rgt
  (make-editor (cons "d" '()) (cons "f" (cons "g" '()))))
 (make-editor (cons "f" (cons "d" '())) (cons "g" '())))

(check-expect
 (editor-rgt
  (make-editor (cons "a" (cons "b" '())) '()))
 (make-editor (cons "a" (cons "b" '())) '()))

; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible 
(define (editor-rgt ed)
  (if (empty? (editor-post ed))
      ed
      (make-editor
       (cons (first (editor-post ed)) (editor-pre ed))
       (rest (editor-post ed)))))

(check-expect
 (editor-del
  (make-editor '() (cons "a" (cons "b" '()))))
 (make-editor '() (cons "a" (cons "b" '()))))

(check-expect
 (editor-del
  (make-editor (cons "d" '()) (cons "f" (cons "g" '()))))
 (make-editor '() (cons "f" (cons "g" '()))))

(check-expect
 (editor-del
  (make-editor (cons "d" (cons "a" '())) (cons "f" (cons "g" '()))))
 (make-editor (cons "a" '()) (cons "f" (cons "g" '()))))

; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible 
(define (editor-del ed)
    (if (empty? (editor-pre ed))
      ed
      (make-editor
       (rest (editor-pre ed))
       (editor-post ed))))