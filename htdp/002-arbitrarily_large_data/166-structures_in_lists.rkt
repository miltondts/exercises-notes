;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 166-structures_in_lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 166

(define MOCK_WORKER_1 "Robby")
(define MOCK_WORKER_RATE_1 2)
(define MOCK_WORKER_HOURS_1 40)
(define MOCK_WORKER_ID_1 1234)
(define MOCK_WORKER_2 "Bran")
(define MOCK_WORKER_RATE_2 3)
(define MOCK_WORKER_HOURS_2 30)
(define MOCK_WORKER_ID_2 4321)

(define-struct employee [name number])
; An (element of) employee is a structure:
; (make-employee String Number)
; interpretation: make-employee stores all employee information

(define-struct revised-work [employee rate hours])
(define-struct work [name rate hours])
; An (element of) work is a structre:
; (make-work String Number Number)
; interpretation: make-work combines the name with the pay rate and
; the number of hours worked in a week

; Low (short for list-of-work) is on of:
; '()
; (cons Work Low)
; interpretation: an instance of Low represents the hours worked by a
; number of employees

(define-struct revised-paycheck [employee amount])
(define-struct paycheck [name amount])
; An (element of) paycheck is a structure:
; (make-paycheck String Number)
; interpretation: make-paycheck combines the name of a worker with
; the amount due on his/hers paycheck

; Lop (short for list-of-paychecks) is on of:
; '()
; (cons Paycheck Lop)
; interpretation: an instance of Lop represents the paycheck for each
; worker

(define ex1 (make-work MOCK_WORKER_1 MOCK_WORKER_RATE_1 MOCK_WORKER_HOURS_1))
(define ex2 (make-work MOCK_WORKER_2 MOCK_WORKER_RATE_2 MOCK_WORKER_HOURS_2))
(define ex3 (cons ex1 (cons ex2 '())))
(define ex4 (make-revised-work (make-employee MOCK_WORKER_1 MOCK_WORKER_ID_1) MOCK_WORKER_RATE_1 MOCK_WORKER_HOURS_1))
(define ex5 (make-revised-work (make-employee MOCK_WORKER_2 MOCK_WORKER_ID_2) MOCK_WORKER_RATE_2 MOCK_WORKER_HOURS_2))
(define ex6 (cons ex4 (cons ex5 '())))

(check-expect (wage.v3 ex1)
              (make-paycheck MOCK_WORKER_1 (* MOCK_WORKER_RATE_1 MOCK_WORKER_HOURS_1)))
(check-expect (wage*.v3 '())
              '())
(check-expect (wage*.v3 ex3)
              (cons (make-paycheck MOCK_WORKER_1 (* MOCK_WORKER_RATE_1 MOCK_WORKER_HOURS_1))
                    (cons (make-paycheck MOCK_WORKER_2 (* MOCK_WORKER_RATE_2 MOCK_WORKER_HOURS_2)) '())))
(check-expect (wage.v4 ex4) (make-revised-paycheck (make-employee MOCK_WORKER_1 MOCK_WORKER_ID_1) (* MOCK_WORKER_RATE_1 MOCK_WORKER_HOURS_1)))
(check-expect (wage*.v4 '()) '())
(check-expect (wage*.v4 ex6)
              (cons (make-revised-paycheck (make-employee MOCK_WORKER_1 MOCK_WORKER_ID_1) (* MOCK_WORKER_RATE_1 MOCK_WORKER_HOURS_1))
                    (cons (make-revised-paycheck (make-employee MOCK_WORKER_2 MOCK_WORKER_ID_2) (* MOCK_WORKER_RATE_2 MOCK_WORKER_HOURS_2)) '())))

; Computes the paycheck of one worker
; Work -> Paycheck
(define (wage.v3 w)
  (make-paycheck (work-name w) (* (work-rate w) (work-hours w))))

; Compute the paycheck for each employee
; List-of-work -> List-of-paycheck
(define (wage*.v3 low)
  (cond
    [(empty? low) '()]
    [(cons? low)
     (cons (wage.v3 (first low)) (wage*.v3 (rest low)))]))

; Computes the revised-paycheck of one revised-worker
; Revised-work -> Revised-paycheck
(define (wage.v4 rw)
  (make-revised-paycheck
   (revised-work-employee rw) (* (revised-work-rate rw) (revised-work-hours rw))))

; Compute the paycheck for each employee
; List-of-revised-work -> List-of-revised-paycheck
(define (wage*.v4 lorw)
  (cond
    [(empty? lorw) '()]
    [(cons? lorw)
     (cons (wage.v4 (first lorw)) (wage*.v4 (rest lorw)))]))