;; Exercise 1.8: Newton's method for cube roots is based on the fact that
;; if y is an approximation to the cube root of x, then a better
;; approximation is given by the value:  (x/y^2 + 2y) / 3
;;
;; Use this formula to implement a cube-root procedure analogous to the
;; square-root procedure. (In 1.3.4 we will see how to implement Newton's
;; method in general as an abstraction of these square-root and cube-root
;; procedures.)

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (cube-root x)
  (define (improve-cube guess x)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3))
  (define (cube-error guess x)
    (abs (- (cube guess) x)))
  (define (good-enough? last-err cur-err)
    (< (abs (- last-err cur-err)) 0.00001))
  (define (cube-root-iter guess x last-err)
    (define cur-err (cube-error guess x))
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
