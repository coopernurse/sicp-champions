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

