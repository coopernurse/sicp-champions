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
