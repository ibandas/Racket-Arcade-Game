;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ravioli) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; a Dish is:
;; (make-dish Filling Sauce)

;; a Filling is one of:
;; - "ricotta"
;; - "butternut squash"
;; - "lobster"

;; a Sauce is one of:
;; - "tomato"
;; - "cream"
;; - "wild-mushroom"
(define-struct dish [filling sauce])
; Enunmerations - 9 distinct possibilities
; 3 combinations using ricotta
(define DISH1 (make-dish "ricotta" "tomato"))
(define DISH2 (make-dish "ricotta" "cream"))
(define DISH3 (make-dish "ricotta" "wild-mushroom"))
; 3 combinations using butternut squash
(define DISH4 (make-dish "butternut-squash" "tomato"))
(define DISH5 (make-dish "butternut-squash" "cream"))
(define DISH6 (make-dish "butternut-squash" "wild-mushroom"))
; 3 combinations using lobster
(define DISH7 (make-dish "lobster" "tomato"))
(define DISH8 (make-dish "lobster" "cream"))
(define DISH9 (make-dish "lobster" "wild-mushroom"))


; al-pomodoro: Filling -> Dish
; Takes in a filling and returns a dish with tomato sauce
(check-expect (al-pomodoro "ricotta") DISH1)
(check-expect (al-pomodoro "butternut-squash") DISH4)
(check-expect (al-pomodoro "lobster") DISH7)
; Strategy: Structural Decomposition
(define (al-pomodoro filling)
  (make-dish filling "tomato"))


; is-vegan?: Dish -> String
; interp. String will be one of:
; 1. IS NOT VEGAN (Combinations involving ricotta, lobster, cream)
; 2. IS VEGAN (Everything else)
(check-expect (is-vegan? DISH1) "IS NOT VEGAN")
(check-expect (is-vegan? DISH3) "IS NOT VEGAN")
(check-expect (is-vegan? DISH4) "IS VEGAN")
(check-expect (is-vegan? DISH5) "IS NOT VEGAN")
(check-expect (is-vegan? DISH8) "IS NOT VEGAN")
; Strategy: Structural Decomposition + Function Composition
(define (is-vegan? dish)
  (cond
    [(string=? (dish-filling dish) "ricotta") "IS NOT VEGAN"]
    [(string=? (dish-filling dish) "lobster") "IS NOT VEGAN"]
    [(string=? (dish-sauce dish) "cream") "IS NOT VEGAN"]
    [else "IS VEGAN"]))

; choose: Boolean -> Dish
; interp. Dish will result in two possibilities:
; 1. True -> (make-dish "butternut-squash" "cream")
; 2. False -> (make-dish "lobster" "wild-mushroom")
(check-expect (choose #true) DISH5)
(check-expect (choose #false) DISH9)
; Strategy: Structural Decomposition
(define (choose dish)
  (cond
    [dish DISH5]
    [else DISH9]))

;; a List-of-Dishes is:
;; - '()
;; - (cons Dish List-of-Dishes)
; only-vegan: [List-of-Dishes] -> [List-of-Dishes]
; interp. Takes in a list of ravioli dishes
; And returns a list of dishes that are vegan
(define list-of-dishes (list DISH1 DISH2 DISH3 DISH4 DISH5 DISH6 DISH7 DISH8 DISH9))
(check-expect (only-vegan list-of-dishes) (list DISH4 DISH6))
(check-expect (only-vegan '()) '())
; Strategy: Structural Decomposition
(define (only-vegan dishes)
  (cond
    [(empty? dishes) '()]
    [else   (if (string=? "IS VEGAN" (is-vegan? (first dishes)))
                (cons (first dishes) (only-vegan (rest dishes)))
                (only-vegan (rest dishes)))]))

