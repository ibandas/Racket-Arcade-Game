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

- `al-pomodoro` takes any filling and returns the combination of that
  same filling with tomato sauce.

- `choose` takes a Boolean; given `#true` it returns butternut squash
  filling with cream sauce, and given `#false` it returns lobster
  filling with wild mushroom sauce.

- `is-vegan?` takes any combination and returns whether that combination
  is vegan. Combinations that involve ricotta filling, lobster filling,
  or cream sauce are not vegan; all others are.

- `only-vegan` takes a list of ravioli dishes and returns a list that
  contains only the vegan dishes from the original list.


Design a data-type to represent ravioli dishes that allows you to
represent any possible ravioli combination.

Then design the four functions described above. Follow the Design Recipe.
|#

;; The coverage checker doesn’t like empty (comment-only) files. You can
;; delete this test once you put something else in the file.
(check-expect (add1 2) 3)