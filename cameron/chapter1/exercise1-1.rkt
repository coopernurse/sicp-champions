;; EXERCISE 1.1 --------------------

10
;; ANSWER: 10

(+ 5 3 4)
;; ANSWER: 12

(- 9 1)
;; ANSWER: 8

(/ 6 2)
;; ANSWER: 3

(+ (* 2 4) (- 4 6))
;; ANSWER: 6

(define a 3)
(define b (+ a 1))

(+ a b (* a b))
;; ANSWER: 19

(= a b)
;; ANSWER: #f

(if (and (> b a) (< b (* a b)))
    b
    a)
;; ANSWER: b

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
;; ANSWER: 16

(+ 2 (if (> b a) b a))
;; ANSWER: 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
;; ANSWER: 16 

;; EXERCISE 1.2 -----------------
;; Write the following in prefix form: 
;; (5 + 4 + (2 - (3 - (6 + 4/5)))) / (3(6 - 2)(2-7)
;; ANSWER: 
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))


;; EXERCISE 1.3 -----------------
;; Define a procedure that takes three numbers as arguments and returns the
;; sum of the squares of the two largest numbers.
;; ANSWER:
(define (sumOfLargestSquares x y z)
  (cond ((and (<= x y) (<= x z)) (+ (* y y) (* z z)))
        ((and (<= y x) (<= y z)) (+ (* x x) (* z z)))
        (else (+ (* x x) (* y y)))))

;; EXERCISE 1.4 ------------------
;; Observe that our model of evaluation allows for combinations whose operators 
;; are compound expressions. Use this observation to describe the behavior of 
;; the following procedure:
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; This procedure adds a and b if b is positive otherwise it subtracts b from a.

;; EXERCISE 1.5 ----------------
;; Ben Bitdiddle has invented a test to determine whether the interpreter he 
;; is faced with is using applicative-order evaluation or normal-order evaluation. 
;; He defines the following two procedures:
(define (p) (p))
 
(define (test x y)
  (if (= x 0) 0 y))

;; Then he evaluates the expression:
(test 0 (p))

;; What behavior will Ben observe with an interpreter that uses applicative-order 
;; evaluation? What behavior will he observe with an interpreter that uses 
;; normal-order evaluation?

;; Applicative Order: With applicative order evaluation, the interpreter first
;; evaluates the operator and operands and then applies the resulting procedure 
;; to the resulting arguments. So it first evaluates the operator, test, as the 
;; procedure that was already defined. Then it evaluates the operands, those being 
;; 0 and (p). Since procedure P returns procedure P recursively, the interpreter 
;; will get into an infinite loop.

;; Normal Order: Interpreting this using normal order evaluation, you do not evaluate 
;; the operands until their values are needed. Once the interpreter sees an expression
;; involving only primitive operators, it then performs the evaluation. In this case, 
;; the interpreter would look into the test procedure and substitute the value 0 for
;; x. Then it sees the expression if (= 0 0), which it then evaluates as true and 
;; returns 0. Since (p) is never evaluated it never gets stuck in an infinite loop.


;; EXERCISE 1.6 ---------------
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
    (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x) guess
    (sqrt-iter (improve guess x) x)))

;; What happens when Alyssa attempts to use the new-if procedure to computer the
;; square roots? Explain

;; Not sure - It should be the same, because in the text, it says: 
;; Another way to write the absolute-value procedure is

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

;; Here is yet another way to write the absolute-value procedure:

(define (abs x)
  (if (< x 0)
      (- x)
      x))

;; After some thought, with the applicative order of evaluation approach, if is 
;; defined as a special form. Since new-if is not defined as a special form, it
;; will eval both the predicate, the consequent and the alternative procedures 
;; before applying the operator to them. I believe this would work fine if the 
;; consequent and alternates were simply values and not procedures. The if special 
;; form stops the interpreter from evaluating the consequent or alternate 
;; procedures until the predicate is evaluated. 

;; EXERCISE 1.7 ------------------
;; The good-enough? test used in computing square roots will not be very effective
;; for finding the square roots of very small numbers. Also, in real computers,
;; arithmetic operations are almost always performed with limited precision. This
;; makes our test inadequate for very large numbers. Explain these statements, with 
;; examples showing how the test fails for small and large numbers. An alternative 
;; strategy for implementing good-enough? is to watch how guess changes from one
;; iteration to the next and to stop when the change is a very small fraction of 
;; the guess. Design a square-root procedure that uses this kind of end test. Does 
;; this work better for small and large numbers?

(define (sqrt x)

  (define (average guess y)
    (/ (+ guess y) 2))

  (define (good-enough? guess last-guess)
    (< (abs (- guess last-guess)) 0.00001))

  (define (improve guess)
    (average guess (/ x guess)))

  (define (sqrt-iter guess last-guess)
    (if (good-enough? guess last-guess)
        guess
        (sqrt-iter (improve guess) guess)))

  (sqrt-iter 1.0 2.0))

(sqrt 5)
;; 2.236067977499978
(sqrt 9999999)
;; 3162.2775020544923
(sqrt 0.1)
;; 0.31622776601683794


;; EXERCISE 1.8 ------------------
;; Newton’s method for cube roots is based on the fact that if y is an approximation
;; to the cube root of x, then a better approximation is given by the value

;; (x/y^2+2y)/3

;; Use this formula to implement a cube-root procedure analogous to the square-root
;; procedure. (In 1.3.4 we will see how to implement Newton’s method in general 
;; as an abstraction of these square-root and cube-root procedures.)



(define (cube-root x)

  (define (improve guess)
    (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

  (define (good-enough? guess last-guess)
    (< (abs (- guess last-guess)) 0.00001))

  (define (cube-root-iterator guess last-guess)
    (if (good-enough? guess last-guess) 
      guess
      (cube-root-iterator (improve guess) guess)))

  (cube-root-iterator 1.0 2.0))


(cube-root 9)
;; 2.080083823051904
(cube-root 64)
;; 4.0









