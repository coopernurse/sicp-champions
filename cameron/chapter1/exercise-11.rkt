

;; Exercise 1.11: A function ff is defined by the rule that f(n)=nf(n)=n if n<3n<3 
;; and f(n)=f(n−1)+2f(n−2)+3f(n−3)f(n)=f(n−1)+2f(n−2)+3f(n−3) if n≥3n≥3. 
;; Write a procedure that computes ff by means of a recursive process. 
;; Write a procedure that computes ff by means of an iterative process.


(define (f n)
  (if (< n 3) n
    (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3)))))) 

