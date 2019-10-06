;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname falling) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;
;
;                                                      ;
;     ;;;;                                             ;
;   ;;    ;
;   ;       ;    ;  ; ;;;    ;;;;   ; ;;;    ;;;;    ;;;     ;;;;
;   ;        ;   ;  ;;   ;  ;;  ;;  ;;  ;   ;    ;     ;    ;    ;
;    ;;      ;  ;   ;    ;  ;    ;  ;    ;  ;          ;    ;
;      ;;;   ;  ;   ;    ;  ;    ;  ;    ;  ;;;        ;    ;;;
;         ;   ; ;   ;    ;  ;    ;  ;    ;     ;;;     ;       ;;;
;         ;   ;;    ;    ;  ;    ;  ;    ;       ;     ;         ;
;   ;    ;;   ;;    ;    ;  ;;  ;;  ;;  ;   ;    ;     ;    ;    ;
;    ;;;;;     ;    ;    ;   ;;;;   ; ;;;    ;;;;   ;;;;;;;  ;;;;
;              ;                    ;
;             ;                     ;
;            ;;                     ;
;

#|

For this exercise you will design and implement a
minimalistic, one finger input game. The player
controls a paddle that moves back and forth at the
bottom of the screen. Falling from the heavens are
some items that you're trying to capture on your
paddle. The paddle never stays still; it
continuously moves left and right along the bottom
of the screen.

There is only a single kind of input accepted
(think like a thumb tap on a phone); the tap
reverses the direction of the paddle. That is, if
there is no input, then the paddle moves from the
left edge to the right edge and then back to the
left edge, over and over. When the user taps, then
the paddle reverses direction even when it isn’t
at one of the edges. So, if the user wishes to
keep the paddle in one spot, they can tap
repeatedly.

The player gets 10 points for each falling item
that the paddle catches and loses one point each
time they tap to reverse direction, but the score
never goes below zero.

Use the world data definition given below; note
that there is some ambiguity in this definition.
For example, do the `Posn`s of the fallers
represent their centers or upper-left corners? You
will need to figure out issues like this one and
make sure your code is consistent.

Either way, you should use the center of the
faller to determine if it has fallen off of the
bottom or if it has hit the paddle.

|#

(require 2htdp/image)
(require 2htdp/universe)


;
;
;
;   ;;;;;             ;
;   ;    ;            ;
;   ;     ;   ;;;   ;;;;;;    ;;;
;   ;     ;  ;   ;    ;      ;   ;
;   ;     ;      ;    ;          ;
;   ;     ;  ;;;;;    ;      ;;;;;
;   ;     ; ;    ;    ;     ;    ;
;   ;     ; ;    ;    ;     ;    ;
;   ;    ;  ;   ;;    ;     ;   ;;
;   ;;;;;    ;;; ;     ;;;   ;;; ;
;
;
;
;

; A Faller-world is
;   (make-fw Number Direction List-of-Posn Natural)
; interp.: if `a-fw` is a Faller-world then all of:
; - (fw-paddle a-fw) is the x coordinate of the paddle,
; - (fw-direction a-fw) gives which direction the paddle is moving,
; - (fw-fallers a-fw) is a list of the positions of the fallers, and
; - (fw-score a-fw) is the score.
(define-struct fw (paddle direction fallers score))

; A Direction is one of:
; - "left"
; - "right"
; For now: Boolean for left and right
(define-struct direction [left right])


; A List-of-Posn is one of:
; - '()
; - (cons Posn List-of-Posn)

; A Posn is (make-posn Real Real)
; (Note: `Real` means a real number, which excludes complex numbers.)


;
;
;
;     ;;;;                            ;                       ;
;    ;    ;                           ;                       ;
;   ;        ;;;;   ; ;;;    ;;;;   ;;;;;;    ;;;   ; ;;;   ;;;;;;   ;;;;
;   ;       ;;  ;;  ;;   ;  ;    ;    ;      ;   ;  ;;   ;    ;     ;    ;
;   ;       ;    ;  ;    ;  ;         ;          ;  ;    ;    ;     ;
;   ;       ;    ;  ;    ;  ;;;       ;      ;;;;;  ;    ;    ;     ;;;
;   ;       ;    ;  ;    ;     ;;;    ;     ;    ;  ;    ;    ;        ;;;
;   ;       ;    ;  ;    ;       ;    ;     ;    ;  ;    ;    ;          ;
;    ;    ; ;;  ;;  ;    ;  ;    ;    ;     ;   ;;  ;    ;    ;     ;    ;
;     ;;;;   ;;;;   ;    ;   ;;;;      ;;;   ;;; ;  ;    ;     ;;;   ;;;;
;
;
;
;

;; You will use these named constants in the
;; definitions of your functions to determine the
;; world’s dimensions and when fallers are created.
;; Your program should still work—with no other
;; changes—when these constants are adjusted (within
;; a reasonable range).
(define WORLD-WIDTH 200)   ; window width
(define WORLD-HEIGHT 300)  ; window height
(define MAX-FALLERS 20)    ; maximum faller count
(define INV-P-FALLER 25)   ; inverse of per-tick probability of new faller
(define BACKGROUND (empty-scene WORLD-WIDTH WORLD-HEIGHT))


#|

For the first step, give your game some flavor.
Find or design an image to show as the falling
items and design an image to use as the paddle.
For the paddle, use `2htdp/image` to make an
image, but for the fallers you may find an image
online to include in your program (or you may
compose your own one using `2htdp/image`).

Make your falling image about 20 pixels tall and
20 pixels wide and make your paddle about 12
pixels tall and 50 pixels wide. Use `image-width`
and `image-height` to confirm the sizes.

Please DO NOT paste the image that you find
directly into your code because that makes version
control (Git) not work very well on the resulting
file. Instead, you should save the image as a file
in this directory and load it in your program
using the `bitmap/file` function. For example, if
you save your faller image as `faller.jpg` (in the
same directory as this file), then you can load it
like this:

  (define FALLER-IMAGE (bitmap/file "faller.jpg"))

In order to a new file like `faller.jpg` to be
committed to Git and uploaded to GitHub (so that
we can see it when grading), you need to use the
`git add` command, like so:

  $ git add faller.jpg

When you commit after `git add`, the file that you
added will be included in the commit.

|#

(define FALLER-IMAGE (circle 3 "solid" "red"))  ; <= fix this
(define PADDLE-IMAGE empty-image)  ; <= fix this

(define (testImage image)
  (place-image image 100 150 BACKGROUND))
(testImage FALLER-IMAGE)
;
;
;                                              ;
;    ;;;;;;                           ;        ;
;    ;                                ;
;    ;      ;    ;  ; ;;;     ;;;   ;;;;;;   ;;;     ;;;;   ; ;;;    ;;;;
;    ;      ;    ;  ;;   ;   ;   ;    ;        ;    ;;  ;;  ;;   ;  ;    ;
;    ;;;;;  ;    ;  ;    ;  ;         ;        ;    ;    ;  ;    ;  ;
;    ;      ;    ;  ;    ;  ;         ;        ;    ;    ;  ;    ;  ;;;
;    ;      ;    ;  ;    ;  ;         ;        ;    ;    ;  ;    ;     ;;;
;    ;      ;    ;  ;    ;  ;         ;        ;    ;    ;  ;    ;       ;
;    ;      ;   ;;  ;    ;   ;   ;    ;        ;    ;;  ;;  ;    ;  ;    ;
;    ;       ;;; ;  ;    ;    ;;;      ;;;  ;;;;;;;  ;;;;   ;    ;   ;;;;
;
;
;
;

#|

There are three separate pieces of the game to be
implemented: rendering the world to an image to be
shown on the screen, handling user inputs, and
adjusting the world as time passes.

Here are the sigantures of the three functions:

  draw : Faller-world -> Scene

  key : Faller-world Key-event -> Faller-world

  tick : Faller-world -> Faller-world

`draw` and `key` are fairly well-described by the
description above, but `tick` needs a little more
explanation. Conceptually, it performs several
different tasks:

 1. Move all the fallers down the screen by one
pixel.

 2. If a faller touches the bottom of the screen,
remove it from the world; if it overlaps with the
paddle, also increment the score.

 3. Possibly add a new faller to the list,
starting from the top of the screen.

 4. Move the paddle.

Be sure to compose several different functions to
accomplish these tasks, and not just one
monolithic function that does it all! (And think
carefully about how you might break up the other
two main functions, too.)

Don't forget: the coordinate system has the
origin in the upper-left, with `x` coordinates
increasing rightward and `y` coordinates
increasing *downward*.

|#


;
;
;                    ;;;
;   ;    ;             ;
;   ;    ;             ;
;   ;    ;   ;;;;      ;    ; ;;;
;   ;    ;   ;  ;;     ;    ;;  ;
;   ;;;;;;  ;    ;     ;    ;    ;
;   ;    ;  ;;;;;;     ;    ;    ;
;   ;    ;  ;          ;    ;    ;
;   ;    ;  ;          ;    ;    ;
;   ;    ;   ;         ;    ;;  ;
;   ;    ;   ;;;;;      ;;; ; ;;;
;                           ;
;                           ;
;                           ;
;


; Function to move the faller downward on the y-axis
; "Downward" means increasing the value of the y-coordinate
; descend : [List-of-Posns] -> [List of Posns]
(check-expect (descend '()) '())
(check-expect (descend (list (make-posn 1 1))) (list (make-posn 1 2)))
(check-expect (descend (list (make-posn 100 100) (make-posn 100 110)
                             (make-posn 100 120) (make-posn 100 130)))
                       (list (make-posn 100 101) (make-posn 100 111)
                             (make-posn 100 121) (make-posn 100 131)))
(define (descend fallers)
  (cond
    [(empty? fallers) '()]
    [else (cons (make-posn (posn-x (first fallers))
                           (add1 (posn-y (first fallers))))
                (descend (rest fallers)))]))

; Increment the position of y value by 1 pixel
;(define (increment y)
;  (+ 1 (posn-y y)))

;; In your `tick` function, you need to
;; *sometimes* add a faller to the list of
;; fallers. Use a function like `maybe-add-faller`
;; (below) to (randomly) add a faller to the
;; current list. You may wish to adjust it based
;; on gameplay factors or the way you interpret
;; `Posn`s as fallers. Note that because of the
;; randomness, this function is difficult to test
;; using `check-expect`, so the test example given
;; below just checks the length of the resulting
;; list.

; maybe-add-faller : List-of-Posn -> List-of-Posn
; Adds a random faller with probabilty
; `1/INV-P-FALLERS`, but only if there are fewer than `MAX-FALLERS`
; fallers aleady.
;
; Example:
(check-expect
 (<= 4
     (length
      (maybe-add-faller
       (list (make-posn 0 0)
             (make-posn 1 1)
             (make-posn 2 2)
             (make-posn 3 3))))
     5)
 #true)

; Strategy: decision tree
(define (maybe-add-faller fallers)
  (cond
    [(< (length fallers) MAX-FALLERS)
     (cond
       [(zero? (random INV-P-FALLER))
        (cons (make-posn (random WORLD-WIDTH) 0)
              fallers)]
       [else fallers])]
    [else fallers]))


;; You'll use this `start` function to start your
;; faller game once you’ve completed designing the
;; three main handler functions that it depends
;; on.

; start : Any -> Faller-world
; Starts the faller game. (Argument is ignored.)
;
; Example:
;  - (start 0)
#; ;; [remove this line to uncomment the function]
(define (start _dummy)
  (big-bang (make-fw (/ WORLD-WIDTH 2) "right" '() 0)
    [on-tick tick 1/200]
    [on-key  key]
    [to-draw draw]))
