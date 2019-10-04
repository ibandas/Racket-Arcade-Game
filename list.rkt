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
(check-expect (contains-telephone (list "hello" "world" "telephone")) #true)
(check-expect (contains-telephone (list "hello" "world" "email")) #false)
(define (contains-telephone lst)
  (member "telephone" lst))


; shortest : [NEList-of String] -> String
; Finds the shortest string in `lst`.
; Recursively goes through the function, compares side by side elements,
; removes the smaller string until there is one element,
; and finally extracts the only item left in the list
; within the empty condition
; Hint: https://htdp.org/2019-02-24/part_two.html#%28part._sec~3alists~3ane%29
(check-expect (shortest (list "hello")) "hello")
(check-expect (shortest (list "saturn" "hello")) "hello")
(check-expect (shortest (list "mars" "neptune")) "mars")
(check-expect (shortest (list "mars" "saturn" "neptune")) "mars")
(define (shortest lst)
  (cond
    [(empty? (rest lst)) (first lst)]
    [else (shortest (remove (compare-strings (first lst) (second lst)) lst))]))

; Compares two strings and returns the longest one
; Should not pass in two empty strings
(check-expect (compare-strings "mars" "saturn") "saturn")
(check-expect (compare-strings "saturn" "neptune") "neptune")
; Strategy : Function Composition
(define (compare-strings s1 s2)
  (cond
    [( < (string-length s1)
         (string-length s2)) s2]
    [( > (string-length s1)
         (string-length s2)) s1]))

; mean : [List-of Number] -> Number
; Computes the average of the elements of `lst`.
; Returns 0 if `lst` is empty.
(check-expect (mean (list)) 0)
(check-expect (mean (list 1 2 3)) 2)
(check-expect (mean (list 2 4 6 8 10)) 6)
(check-expect (mean (list 3 7 23 52 70)) 31)
(define (mean lst)
  (cond
  [(empty? lst) 0]
  [else (/ (sum lst) (length lst))]))

; sum : [List-of Number] -> Number
; Calculates the sum
; Strategy : Function Composition
(define (sum lst)
  (cond
  [(empty? (rest lst)) (first lst)]
  [else (+ (first lst) (sum (rest lst)))]))






  