;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname composing_functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 27
(define CURRENT-ATTENDANCE 120)
(define ATENDEE-SHIFT 15)
(define PRICE-SHIFT 0.1)
(define CURRENT-PRICE 5.0)
(define FIXED-COST 180)
(define VARIABLE-COST 0.04)


(define (attendees ticket-price)
  (- CURRENT-ATTENDANCE (* (- ticket-price CURRENT-PRICE) (/ ATENDEE-SHIFT PRICE-SHIFT))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;exercise 28 - reviewed
;The owner of the movie theater should charge 3 dollars a ticket to maximize his profit.
(profit 1)
(profit 2)
(profit 3)
(profit 4)
(profit 5)

(define (profit2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 180
        (* 0.04
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))

(profit2 1)
(profit2 2)
(profit2 3)
(profit2 4)
(profit2 5)

;exercise 29
(define COST-PER-ATENDEE 1.5)

(define (cost2 ticket-price)
  (* COST-PER-ATENDEE (attendees ticket-price)))

(define (profit3 ticket-price)
  (- (revenue ticket-price)
     (cost2 ticket-price)))

(profit3 3)
(profit3 4)
(profit3 5)

(define (profit4 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
      (* 1.5
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price))))))

(profit4 3)
(profit4 4)
(profit4 5)

;exercise 30
(define ATTENDANCE-SENSITIVITY (/ ATENDEE-SHIFT PRICE-SHIFT))