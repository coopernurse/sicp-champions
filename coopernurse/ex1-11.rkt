;; Exercise 1.11.  A function f is defined by the rule that
;;
;; f(n) = n if n < 3 and
;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n > 3
;;
;; Write a procedure that computes f by means of a recursive process.
;; Write a procedure that computes f by means of an iterative process.

(define (f-recur n)
  (if (< n 3)
      n
      (+ (f-recur (- n 1))
         (* 2 (f-recur (- n 2)))
         (* 3 (f-recur (- n 3))))))

(define (f-iter n)
  (define (loop minus-3 minus-2 minus-1 i)
    (define total (if (< i 3)
                      i
                      (+ minus-1 (* 2 minus-2) (* 3 minus-3))))
    (if (= i n)
        total
        (loop minus-2 minus-1 total (+ i 1))))
  (loop 0 0 0 1))

