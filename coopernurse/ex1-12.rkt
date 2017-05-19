;; Exercise 1.11.  The numbers at the edge of the triangle are all 1, and
;; each number inside the triangle is the sum of the two numbers above it.
;;
;; Write a procedure that computes elements of Pascal's triangle by means of a recursive process.
;;

(require racket/format)

;; row and col are 1 based
;;  e.g. row=1 col=1 == number at top of triangle
(define (pascal-triangle-cell row col)
  (cond ((< col 1) 0)
        ((= col 1) 1)
        ((> col row) 0)
        (else (+ (pascal-num (- row 1) (- col 1))
                 (pascal-num (- row 1) col)))))

(define (pascal-triangle-row row)
  (map (lambda (col) (pascal-triangle-cell row (+ 1 col))) (range row)))

(define (pascal-triangle rows)
  (map (lambda (row) (pascal-triangle-row (+ 1 row))) (range rows)))

(define (print-pascal-triangle-row row max-width)
  (define width (* 4 (length row)))
  (define lpad (~a "" #:width (floor (/ (- max-width width) 2)) #:pad-string " "))
  (define cells (map (lambda (cell) (~a cell #:align 'left #:width 4 #:pad-string " ")) row))
  (printf "~a~a\n" lpad (apply string-append cells)))

(define (print-pascal-triangle tri)
  (define max-width (* 4 (length tri)))
  (map (lambda (row) (print-pascal-triangle-row row max-width)) tri))
  
