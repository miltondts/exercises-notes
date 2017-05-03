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

(sine 20.25)
(p (sine 6.75))
(p (p (sine 2.25)))
(p (p (p (sine 0.75))))
(p (p (p (p (sine 0.25)))))
(p (p (p (p (p (sine 0.083333333333)))))) ; => p is applied 5 times

(sine 4.05)
(p (sine 1.35))
(p (p (sine 0.45)))
(p (p (p (sine 0.15))))
(p (p (p (p (sine 0.05)))))
(p (p (p (p 0.05)))) ; => p is applied 5 times

; I'm not sure what the O notation for this procedure will be, but it is better
;than O(n) for both space and the number steps. Extra steps, and an extra call
;to p, are only required once we increase the input 3 fold.

; Note: Probably grows as fast as the logarithm on n to base 3. Making it O(log(n))