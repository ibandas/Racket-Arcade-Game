;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ravioli) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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
(define RIC-TOM (make-dish "ricotta" "tomato"))
(define RIC-CRM (make-dish "ricotta" "cream"))
(define RIC-WILD (make-dish "ricotta" "wild-mushroom"))
; 3 combinations using butternut squash
(define BUT-TOM (make-dish "butternut-squash" "tomato"))
(define BUT-CRM (make-dish "butternut-squash" "cream"))
(define BUT-WILD (make-dish "butternut-squash" "wild-mushroom"))
; 3 combinations using lobster
(define LOB-TOM (make-dish "lobster" "tomato"))
(define LOB-CRM (make-dish "lobster" "cream"))
(define LOB-WILD (make-dish "lobster" "wild-mushroom"))

(define list-of-dishes (list RIC-TOM RIC-CRM RIC-WILD BUT-TOM
                             BUT-CRM BUT-WILD LOB-TOM LOB-CRM LOB-WILD))

; al-pomodoro: Filling -> Dish
; Takes in a filling and returns a dish with tomato sauce
(check-expect (al-pomodoro "ricotta") RIC-TOM)
(check-expect (al-pomodoro "butternut-squash") BUT-TOM)
(check-expect (al-pomodoro "lobster") LOB-TOM)
; Strategy: Structural Decomposition
(define (al-pomodoro filling)
  (make-dish filling "tomato"))


; is-vegan?: Dish -> Boolean
; Asserts the Dish is vegan if it contains
; Ricotta, Lobster, or Cream
(check-expect (is-vegan? RIC-TOM) #false)
(check-expect (is-vegan? RIC-WILD) #false)
(check-expect (is-vegan? BUT-TOM) #true)
(check-expect (is-vegan? BUT-CRM) #false)
(check-expect (is-vegan? LOB-CRM) #false)
; Strategy: Structural Decomposition
(define (is-vegan? dish)
  (not (or (string=? (dish-filling dish) "ricotta")
           (string=? (dish-filling dish) "lobster")
           (string=? (dish-sauce dish) "cream"))))

; choose: Boolean -> Dish
; interp. Dish will result in two possibilities:
; 1. True -> (make-dish "butternut-squash" "cream")
; 2. False -> (make-dish "lobster" "wild-mushroom")
(check-expect (choose #true) BUT-CRM)
(check-expect (choose #false) LOB-WILD)
; Strategy: Structural Decomposition
(define (choose cod)
  (cond
    [cod BUT-CRM]
    [else LOB-WILD]))

;; a List-of-Dishes is:
;; - '()
;; - (cons Dish List-of-Dishes)

; only-vegan: List-of-Dishes -> List-of-Dishes
; Takes in a list of ravioli dishes and returns a list of dishes
; that are vegan

(check-expect (only-vegan list-of-dishes) (list BUT-TOM BUT-WILD))
(check-expect (only-vegan '()) '())
; Strategy: Function Composition
(define (only-vegan dishes)
  (filter is-vegan? dishes))
  

