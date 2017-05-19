;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Exercise 1.10.  The following procedure computes a mathematical function
;; called Ackermann's function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1)))
                 )))

;; What are the values of the following expressions?
;;
;; (A 1 10) => 1024
;; (A 2 4)  => 65536
;; (A 3 3)  => 65536

;; Consider the following procedures, where A is the procedure defined above:

(define (f n) (A 0 n))
(define (g n) (A 1 n))
(define (h n) (A 2 n))
(define (k n) (* 5 n n))

;; Give concise mathematical definitions for the functions computed by the
;; procedures f, g, and h for positive integer values of n.
;; For example, (k n) computes 5n^2.
;;
;; Answers:
;;
;; (f n) -> 2n
;; (g n) -> 2^n
;; (h n) -> 2^2^2...
;;
;;  See: http://jots-jottings.blogspot.com/2011/08/sicp-110-ackermanns-function.html
;;  (h n) is a tetration: https://en.wikipedia.org/wiki/Tetration
;;
;;   (h 1) -> 2        (g 1) -> 2
;;   (h 2) -> 4        (g 2) -> 4
;;   (h 3) -> 16       (g 3) -> 8
;;   (h 4) -> 65536    (g 4) -> 16

;; Substiution for g:
;;
;; (g 2) -> 4
(A 1 2)
(A 0 (A 1 1))
(A 0 2)
(* 2 2)

;; (g 3) -> 8
(A 1 3)
(A 0 (A 1 2))
(A 0 (A 0 (A 1 1)))
(A 0 (A 0 2))
(A 0 4)
(* 2 4)

;; (g 4) -> 16
(A 1 4)
(A 0 (A 1 3))
(A 0 (A 0 (A 1 2)))
(A 0 (A 0 (A 0 (A 1 1))))
(A 0 (A 0 (A 0 2)))
(A 0 (A 0 (* 2 2)))
(A 0 (A 0 4))
(A 0 (* 2 4))
(A 0 8)
(* 2 8)

;; Substitution for h:

;; (h 2)
(A (- 2 1) (A 2 (- 2 1)))
(A 1 (A 2 1))
(A 1 2)

;; (h 4)
(A (- 2 1) (A 2 (- 4 1)))
(A 1 (A 2 3))
(A 1 (A (- 2 1) (A 2 (- 3 1))))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A (- 2 1) (A 2 (- 2 1)))))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A (- 1 1) (A 1 (- 2 1)))))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 (* 2 2)))
(A 1 (A 1 4))   ;; 2^(2^4)
(A 1 (A (- 1 1) (A 1 (- 4 1))))
(A 1 (A 0 (A 1 3)))
(A 1 (A 0 (A (- 1 1) (A 1 (- 3 1)))))
(A 1 (A 0 (A 0 (A 1 2))))
(A 1 (A 0 (A 0 (A (- 1 1) (A 1 (- 2 1))))))
(A 1 (A 0 (A 0 (A 0 (A 1 1)))))
(A 1 (A 0 (A 0 (A 0 2))))
(A 1 (A 0 (A 0 (* 2 2))))
(A 1 (A 0 (A 0 4)))
(A 1 (A 0 (* 2 4)))
(A 1 (A 0 8))
(A 1 (* 2 8))
(A 1 16)
