;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; squares : [List-of Number] -> [List-of Number]
; Squares each number in the list, producing a new list.
(check-expect (squares '()) '())
(check-expect (squares (list 10 0 20)) (list 100 0 400))
(check-expect (squares (list 1 2 3 4 5)) (list 1 4 9 16 25))
; Strategy: Structural Decomposition
(define (squares l)
  (cond
    [(empty? l) '()]
    [else (cons (* (first l) (first l)) (squares (rest l)))]))

; contains-telephone : [List-of String] -> Boolean
; Determines whether `lst` contains the string "telephone".
(check-expect (contains-telephone (list "hello" "world" "telephone")) #true)
(check-expect (contains-telephone (list "hello" "world" "email")) #false)
; Strategy: Structural Decomposition
(define (contains-telephone lst)
  (cond
    [(empty? lst) #false]
    [(string=? (first lst) "telephone") #true]
    [else (contains-telephone (rest lst))]))


; shortest : [NEList-of String] -> String
; Finds the shortest string in `lst`.
(check-expect (shortest (list "hello")) "hello")
(check-expect (shortest (list "saturn" "hello")) "hello")
(check-expect (shortest (list "mars" "neptune")) "mars")
(check-expect (shortest (list "mars" "saturn" "neptune")) "mars")
(check-expect (shortest (list "earth" "pluto" "saturn" "neptune")) "earth")
; Strategy: Structural Decomposition
(define (shortest lst)
  (cond
    [(empty? (rest lst)) (first lst)]
    [else (shortest (remove (compare-strings (first lst) (second lst)) lst))]))

; compare-strings: String String -> String
; Compares two strings and returns the longest one
; Should not pass in two empty strings
; interp. If two strings are equal, it will just return the second string
(check-expect (compare-strings "mars" "saturn") "saturn")
(check-expect (compare-strings "saturn" "neptune") "neptune")
(check-expect (compare-strings "mercury" "pluto") "mercury")
(check-expect (compare-strings "earth" "pluto") "pluto")
; Strategy : Function Composition
(define (compare-strings s1 s2)
  (cond
    [( < (string-length s1)
         (string-length s2)) s2]
    [( > (string-length s1)
         (string-length s2)) s1]
    [else s2]))

; mean : [List-of Number] -> Number
; Computes the average of the elements of `lst`.
; Returns 0 if `lst` is empty.
(check-expect (mean (list)) 0)
(check-expect (mean (list 1 2 3)) 2)
(check-expect (mean (list 2 4 6 8 10)) 6)
(check-expect (mean (list 3 7 23 52 70)) 31)
; Strategy : Structural Composition
(define (mean lst)
  (cond
  [(empty? lst) 0]
  [else (/ (sum lst) (length lst))]))

; sum : [List-of Number] -> Number
; Calculates the sum of a non-empty list
(check-expect (sum (list 1)) 1)
(check-expect (sum (list 1 2 3 4 5)) 15)
(check-expect (sum (list 23 57 2 17)) 99)
; Strategy : Function Composition
(define (sum lst)
  (cond
  [(empty? (rest lst)) (first lst)]
  [else (+ (first lst) (sum (rest lst)))]))






  