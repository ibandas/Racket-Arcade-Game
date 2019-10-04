;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ravioli) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
Dave’s New Kitchen (on Noyes St. in Evanston) offers ravioli with 3
fillings (ricotta, butternut squash, lobster) with a choice of 3
sauces (tomato, cream, wild mushroom).

How could you represent a ravioli filling/sauce combination as data?
In particular, consider how your representation would allow you to
define these functions:


Design a data-type to represent ravioli dishes that allows you to
represent any possible ravioli combination.

Then design the four functions described above. Follow the Design Recipe.
|#

; Struct named "ingredient" that takes in a String String String
; for the name of the ingredient, the type (filling or sauce)
; and if it is "vegan" or "not vegan"
(define-struct ingredient [name type veganity])
; Fillings
(define ricotta (make-ingredient "ricotta" "filling" "not-vegan"))
(define butternut-squash (make-ingredient "butternut-squash" "filling" "vegan"))
(define lobster (make-ingredient "lobster" "filling" "not-vegan"))
; Sauces
(define tomato (make-ingredient "tomato" "sauce" "vegan"))
(define cream (make-ingredient "cream" "sauce" "not-vegan"))
(define wild-mushroom (make-ingredient "wild-mushroom" "sauce" "vegan"))

; Struct named "dish" that takes in an ingredient ingredient
; for filling and sauce
(define-struct dish [filling sauce])
; Enunmerations - 9 distinct possibilities
; 3 combinations using ricotta
(define DISH1 (make-dish ricotta tomato))
(define DISH2 (make-dish ricotta cream))
(define DISH3 (make-dish ricotta wild-mushroom))
; 3 combinations using butternut squash
(define DISH4 (make-dish butternut-squash tomato))
(define DISH5 (make-dish butternut-squash cream))
(define DISH6 (make-dish butternut-squash wild-mushroom))
; 3 combinations using lobster
(define DISH7 (make-dish lobster tomato))
(define DISH8 (make-dish lobster cream))
(define DISH9 (make-dish lobster wild-mushroom))


; `al-pomodoro` takes any filling and returns the combination of that
;  same filling with tomato sauce.

; Takes in ingredient and returns dish if given a filling
; If given a ingredient of type sauce or something else
; it will return "Not a filling"
(check-expect (al-pomodoro ricotta) DISH1)
(check-expect (al-pomodoro butternut-squash) DISH4)
(check-expect (al-pomodoro lobster) DISH7)
(check-expect (al-pomodoro tomato) "Not a filling")
(define (al-pomodoro filling)
  (cond
    [(string=? (ingredient-type filling) "filling")
     (make-dish filling tomato)]
    [else "Not a filling"]))


; Pass a dish and return a "vegan" or "not vegan" 
; `is-vegan?` takes any combination and returns whether that combination
;  is vegan. Combinations that involve ricotta filling, lobster filling,
;  or cream sauce are not vegan; all others are.
(check-expect (is-vegan? DISH1) "IS NOT VEGAN")
(check-expect (is-vegan? DISH3) "IS NOT VEGAN")
(check-expect (is-vegan? DISH4) "IS VEGAN")
(check-expect (is-vegan? DISH5) "IS NOT VEGAN")
(check-expect (is-vegan? DISH8) "IS NOT VEGAN")
; Possibly change else so it doesn't take a non-dish
(define (is-vegan? dish)
  (cond
    [(and (string=? (ingredient-veganity (dish-filling dish)) "vegan")
          (string=? (ingredient-veganity (dish-sauce dish)) "vegan")) "IS VEGAN"]
    [else "IS NOT VEGAN"]))


; `choose` takes a Boolean; given `#true` it returns butternut squash
;  filling with cream sauce, and given `#false` it returns lobster
;  filling with wild mushroom sauce.
(check-expect (choose #true) DISH5)
(check-expect (choose #false) DISH9)
(check-expect (choose "hello") "Not given a boolean")
(define (choose dish)
  (cond
    [ (equal? #true dish) DISH5]
    [ (equal? #false dish) DISH9]
    [else "Not given a boolean"]))

; Pass a list and return a list
; `only-vegan` takes a list of ravioli dishes and returns a list that
; contains only the vegan dishes from the original list.
(define list-of-dishes (list DISH1 DISH2 DISH3 DISH4 DISH5 DISH6 DISH7 DISH8 DISH9))
(check-expect (only-vegan list-of-dishes) (list DISH4 DISH6))
(check-expect (only-vegan '()) '())
(define (only-vegan dishes)
  (cond
    [(empty? dishes) '()]
    [else   (if (string=? "IS VEGAN" (is-vegan? (first dishes)))
                (cons (first dishes) (only-vegan (rest dishes)))
                (only-vegan (rest dishes)))]))

