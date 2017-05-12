#lang sicp

; exercise 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

; applicative-order evaluation goes into an endless look, as (p) never defined, and just keeps calling itself
; normal-order evaluation would evaluate to zero as the conditional would evaluate true, and skip the call to (p)





