;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Design the following functions.


; squares : [List-of Number] -> [List-of Number]
; Squares each number in the list, producing a new list.
(check-expect (squares '()) '())
(check-expect (squares (list 10 0 20)) (list 100 0 400))
(check-expect (squares (list 1 2 3 4 5)) (list 1 4 9 16 25))
(define (squares l)
  (cond
    [(empty? l) '()]
    [else (cons (* (first l) (first l)) (squares (rest l)))]))

; contains-telephone : [List-of String] -> Boolean
; Determines whether `lst` contains the string "telephone".
(define (contains-telephone lst)
  ...)


; shortest : [NEList-of String] -> String
; Finds the shortest string in `lst`.
;
; Hint: https://htdp.org/2019-02-24/part_two.html#%28part._sec~3alists~3ane%29
(define (shortest lst)
  ...)


; mean : [List-of Number] -> Number
; Computes the average of the elements of `lst`.
; Returns 0 if `lst` is empty.
(define (mean lst)
  ...)
