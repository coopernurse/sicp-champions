;; Exercise 1.7.  The good-enough? test used in computing square roots
;; will not be very effective for finding the square roots of very small
;; numbers. Also, in real computers, arithmetic operations are almost
;; always performed with limited precision. This makes our test
;; inadequate for very large numbers. Explain these statements, with
;; examples showing how the test fails for small and large numbers. An
;; alternative strategy for implementing good-enough? is to watch how
;; guess changes from one iteration to the next and to stop when the
;; change is a very small fraction of the guess. Design a square-root
;; procedure that uses this kind of end test. Does this work better for
;; small and large numbers?

;; Answers:
;;
;; The basic problem is that the error tolerance of the previous sqrt
;; implementation is fixed at 0.001, so for small numbers we stop
;; searching too early, and for large numbers we iterate for too long.
;;
;;   ;; small numbers - we never do better than our fixed tolerance
;;   (sqrt 3)  => 1.7321428571428572   (actual: 1.7320508075688)
;;   (sqrt .1) => 0.316245562280389    (actual: 0.3162277660168)
;;
;;
;;   ;; large numbers - we sometimes never finish
;;   (sqrt 99999999999999999)  => never completes
;;
;;
;; The revised implementation stops when the marginal improvement
;; is lower than a fixed tolerance.  This provides better accuracy
;; for small numbers, and terminates in a reasonable time for large
;; numbers.
;;
;;   ;; small numbers
;;   (sqrt-17 3)  => 1.7320508075688772   (actual: 1.7320508075688)
;;   (sqrt-17 .1) => 0.31622776601683794  (actual: 0.3162277660168)
;;
;;   ;; large numbers
;;   (sqrt-17 99999999999999999) => 316227766.01683795
;;

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-17 x)
  (define (sqrt-error guess)
    (abs (- (square guess) x)))
  ; is the last error sufficiently close to the current error?
  ; if so, the guess is good enough, as we've found a local optima
  (define (good-enough? last-err cur-err)
    (< (abs (- last-err cur-err)) 0.00001))
  (define (sqrt-iter guess last-err)
    (define cur-err (sqrt-error guess))
    (if (good-enough? last-err cur-err)
        guess
        (sqrt-iter (improve guess x) cur-err)))
  (sqrt-iter 1.0 (square x)))
