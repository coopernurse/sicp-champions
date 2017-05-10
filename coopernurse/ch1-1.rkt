
;;
;; Exercise 1.1: Below is a sequence of expressions. What is the result
;; printed by the interpreter in response to each expression? Assume that
;; the sequence is to be evaluated in the order in which it is presented.
;;

;; 10 => 10
;; (+ 5 3 4) => 12
;; (- 9 1) => 8
;; (/ 6 2) => 3
;; (+ (* 2 4) (- 4 6)) => 6
;; (define a 3) => <no output>
;; (define b (+ a 1)) => <no output>
;; (+ a b (* a b)) => 19
;; (= a b) => #f

;; (if (and (> b a) (< b (* a b)))
;;     b
;;     a)
;; => 4

;; (cond ((= a 4) 6)
;;       ((= b 4) (+ 6 7 a))
;;       (else 25))
;; => 16

;; (+ 2 (if (> b a) b a)) => 6

;; (* (cond ((> a b) a)
;;          ((< a b) b)
;;          (else -1))
;;    (+ a 1))
;; => 16


;; Exercise 1.2: Translate the following expression into prefix form:
;; 
;;        5 + 4 + (2 - (3 - (6 + 4/5)))
;;        -----------------------------
;;                3(6 - 2)(2 - 7)

(/
 (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
 (* 3 (- 6 2) (- 2 7)))


;;
;; Exercise 1.3: Define a procedure that takes three numbers as arguments
;; and returns the sum of the squares of the two larger numbers.
;;

(define (sum-of-squares-largest-two x y z)
  (cond ((and (<= x y) (<= x z)) (+ (* y y) (* z z)))
        ((and (<= y x) (<= y z)) (+ (* x x) (* z z)))
        (else (+ (* x x) (* y y)))))


;; Exercise 1.4: Observe that our model of evaluation allows for
;; combinations whose operators are compound expressions. Use this
;; observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; Answer:
;; The if form evaluates to an operator (either + or -) which is
;; then applied to the remaining parameters a and b.
;;
;; If b is positive or zero it is added to a, otherwise b is subtracted from a.
;; Consequently, either way the absolute value of b is added to a.


;; Exercise 1.5: Ben Bitdiddle has invented a test to determine whether the
;; interpreter he is faced with is using applicative-order evaluation or
;; normal-order evaluation. He defines the following two procedures:

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;; Then he evaluates the expression

;; (test 0 (p))

;; What behavior will Ben observe with an interpreter that uses
;; applicative-order evaluation? What behavior will he observe with an
;; interpreter that uses normal-order evaluation?

;; Answer:
;; With applicative-order evaluation the expression will never finish
;; evaluating because the 2nd parameter to test: '(p)' will be evaluated
;; before test is invoked.  Procedure 'p' calls itself recursively and
;; will never return.
;;
;; With normal-order evaluation, the expression will return 0.
;; In this case the 2nd paramter to test will not be evaluated immediately.
;; test will be invoked, the if expression will test true, and 0 will be
;; returned. The alternative expression 'y' will never be evaluated, so
;; procedure 'p' will never be invoked.


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
(define (sqrt-17 x)
  (define (sqrt-error guess x)
    (abs (- (square guess) x)))
  ; is the last error sufficiently close to the current error?
  ; if so, the guess is good enough, as we've found a local optima
  (define (good-enough? last-err cur-err)
    (< (abs (- last-err cur-err)) 0.00001))
  (define (sqrt-iter guess x last-err)
    (define cur-err (sqrt-error guess x))
    (if (good-enough? last-err cur-err)
        guess
        (sqrt-iter (improve guess x) x cur-err)))
  (sqrt-iter 1.0 x (square x)))


;; Exercise 1.8: Newton's method for cube roots is based on the fact that
;; if y is an approximation to the cube root of x, then a better
;; approximation is given by the value:  (x/y^2 + 2y) / 3
;;
;; Use this formula to implement a cube-root procedure analogous to the
;; square-root procedure. (In 1.3.4 we will see how to implement Newton's
;; method in general as an abstraction of these square-root and cube-root
;; procedures.)

(define (cube x) (* x x x))

(define (cube-root x)
  (define (improve-cube guess x)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))
  (define (cube-error guess x)
    (abs (- (cube guess) x)))
  (define (good-enough? last-err cur-err)
    (< (abs (- last-err cur-err)) 0.00001))
  (define (cube-root-iter guess x last-err)
    (define cur-err (sqrt-error guess x))
    (if (good-enough? last-err cur-err)
        guess
        (cube-root-iter (improve-cube guess x) x cur-err)))
  (cube-root-iter 1.0 x (cube x)))


;; if we wanted to eliminate the duplicate code between sqrt-17 and cube-root-18
;; we could factor out the improve and cube/square functions:

(define (iterative-converge x improve opposite-fn)
  (define (get-error guess x)
    (abs (- (opposite-fn guess) x)))
  (define (good-enough? last-err cur-err)
    (< (abs (- last-err cur-err)) 0.00001))
  (define (iter guess x last-err)
    (define cur-err (get-error guess x))
    (if (good-enough? last-err cur-err)
        guess
        (iter (improve guess x) x cur-err)))
  (iter 1.0 x (opposite-fn x)))

(define (sqrt-generic x)
  (define (improve guess x)
    (average guess (/ x guess)))
  (iterative-converge x improve square))

(define (cube-root-generic x)
  (define (improve guess x)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))    
  (iterative-converge x improve cube))
