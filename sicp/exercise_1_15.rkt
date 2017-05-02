#lang scheme

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

; a) How many times is procedure p applied when evaluating (sine 12.15)?
(sine 12.15)
(p (sine 4.05))
(p (p (sine 1.35)))
(p (p (p (sine 0.45))))
(p (p (p (p (sine 0.15)))))
(p (p (p (p (p (sine 0.05))))))
(p (p (p (p (p 0.05)))))
; R: THe procedure p is applied 5 times when evaluating (sine 12.15)

; b) What is the order of growth in space and time when of the process generated?
(sine 36.45)
(p (sine 12.15))
(p (p (sine 4.05)))
(p (p (p (sine 1.35))))
(p (p (p (p (sine 0.45)))))
(p (p (p (p (p (p (sine 0.05)))))))
(p (p (p (p (p (p 0.05)))))) ; => p is applied 6 times

(sine 4.05)
(p (sine 1.35))
(p (p (sine 0.45)))
(p (p (p (sine 0.15))))
(p (p (p (p (sine 0.05)))))
(p (p (p (p 0.05)))) ; => p is applied 5 times


      