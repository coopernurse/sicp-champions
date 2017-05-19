;; Exercise 1.6.  Alyssa P. Hacker doesn't see why if needs to be provided
;; as a special form. ``Why can't I just define it as an ordinary procedure
;; in terms of cond?'' she asks. Alyssa's friend Eva Lu Ator claims this
;; can indeed be done, and she defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; Eva demonstrates the program for Alyssa:
;; (new-if (= 2 3) 0 5)
;; 5
;; (new-if (= 1 1) 0 5)
;; 0

;; Delighted, Alyssa uses new-if to rewrite the square-root program:
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (square x) (* x x))
(define (average x y)
  (/ (+ x y) 2))
(define (improve guess x)
  (average guess (/ x guess)))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

;; What happens when Alyssa attempts to use this to compute square roots? Explain.

;; Answer:
;; 
;; sqrt-iter will never return, because new-if is a standard procedure whose
;; paramters will be evaluated before new-if is invoked.
;;
;; These procedures will all be invoked before new-if:
;;     (good-enough? guess x)
;;     (improve guess x)
;;     (sqrt-iter)
;;
;; This is why if must be defined as a special form which is not subject
;; to the rules of applicative-order evaluation.
