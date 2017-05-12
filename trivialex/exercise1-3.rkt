#lang sicp

; exercise 1.3;

(define (square a)
  (* a a))

(define (sum-of-largest-squares a b c)
  (+ (square (if (> a b)
                    a
                    b))
     (square (if (> b c)
                 b
                 c)
             )))


(sum-of-largest-squares 2 3 4)

(sum-of-largest-squares 2 4 4)
  

      

