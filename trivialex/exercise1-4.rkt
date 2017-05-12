#lang sicp

; exercise 1.4

;defines process named 'a-plus-abs-b' with parameters 'a' and 'b'
; tests if 'b' is greater than zero, and if so adds it to 'a'
; if 'b' less than or equal to zero, subtracts it from 'a'

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 3 -2)

