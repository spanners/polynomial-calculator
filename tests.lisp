;;; Test 1
; p = -8 + 2x + 3yx^2 + x + 0z + x^0x
(setq p '((-8 (())) (2 ((x 1))) (3 ((y 1) (x 2))) (1 ((x 1))) (0 ((z 1))) (1 ((x 0) (x 1)))))

;; Test Description:
;; This is possibly the worst-case (but still valid) polynomial in need of simplifying.
;; "Valid" means it can be generated by p+, p- or p* before being cleaned with (clean)
;; Like terms are separated by unlike terms and are not collected into one term
;; Like variables are not collected into one variable.
;; It contains a term with coefficient 0.
;; It contains a term with a variable raised to the power 0.

;; Test 1.1
(setq expected '((-8 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "1.1: ")
(print (p= (clean p) expected))

;; Test 1.2
(setq expected '((-16 (())) (8 ((x 1))) (6 ((y 1) (x 2)))))
(prin "1.2: ")
(print (p= (p+ p p) expected))

;; Test 1.3
(setq expected '((64 (())) (-64 ((x 1))) (-48 ((y 1) (x 2))) (16 ((x 2))) (12 ((x 3) (y 1))) (12 ((y 1) (x 3))) (9 ((y 2) (x 4)))))
(prin "1.3: ")
(print (p= (p* p p) expected))

;;; Test 2
; p = 0
; q =  -8 + 2x + 3yx^2 + x + 0z + x^0x
(setq p '((0 (()))))
(setq q '((-8 (())) (2 ((x 1))) (3 ((y 1) (x 2))) (1 ((x 1))) (0 ((z 1))) (1 ((x 0) (x 1)))))

;; Test Description:
;; Check that we can perform operations with 0 on both sides of each operator
;; Tests 2.2 - 2.4: 0 on left side
;; Tests 2.5 - 2.7: 0 on right side

;; Test 2.1
(setq expected '())
(prin "2.1: ")
(print (p= (clean p) expected))

;; Test 2.2
(setq expected '((-8 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "2.2: ")
(print (p= (p+ p q) expected))

;; Test 2.3
(setq expected '((8 (())) (-4 ((x 1))) (-3 ((y 1) (x 2)))))
(prin "2.3: ")
(print (p= (p- p q) expected))

;; Test 2.4
(setq expected '())
(prin "2.4: ")
(print (p= (p* p q) expected))

;; Test 2.5
(setq expected '((-8 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "2.5: ")
(print (p= (p+ q p) expected))

;; Test 2.6
(setq expected '((-8 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "2.6: ")
(print (p= (p- q p) expected))

;; Test 2.7
(setq expected '())
(prin "2.7: ")
(print (p= (p* q p) expected))

;;; Test 3
; p = -8 + 2x + 3yx^2 + x + 0z + x^0x
; q = 2x - 8 + x + 3yx^2 + x^0x + 0z
(setq p '((-8 (())) (2 ((x 1))) (3 ((y 1) (x 2))) (1 ((x 1))) (0 ((z 1))) (1 ((x 0) (x 1)))))
(setq q '((2 ((x 1))) (-8 (())) (1 ((x 1))) (3 ((y 1) (x 2))) (1 ((x 0) (x 1))) (0 ((z 1)))))

;; Test Description:
;; To test p=, since p and q are equal, but their terms are not in the same order.

;; Test 3.1
(setq expected t)
(prin "3.1: ")
(print (equal (p= p q) expected))

;;; Test 4
; p = 3yx^2 
; q = 3x^2y
(setq p '((3 ((y 1) (x 2)))))
(setq q '((3 ((x 2) (y 1)))))

;; Test Description:
;; To test all operators since p and q are equal, but their variables are not in the same order

;; Test 4.1
(setq expected t)
(prin "4.1: ")
(print (equal (p= p q) expected))

;; Test 4.2
(setq expected '((6 ((y 1) (x 2)))))
(prin "4.2: ")
(print (p= (p+ p q) expected))

;; Test 4.3
(setq expected '())
(prin "4.3: ")
(print (equal (p- p q) expected))

;; Test 4.4
(setq expected '((9 ((y 2) (x 4)))))
(prin "4.4: ")
(print (p= (p* p q) expected))

;;: Test 5
; p = 3yx^2
; q = 3yx^3
(setq p '((3 ((y 1) (x 2)))))
(setq q '((3 ((y 1) (x 3)))))

;; Test Description:
;; To test p=, since p and q are same length with same number of variables, but one variable has unequal powers

;; Test 5.1
(setq expected '())
(prin "5.1: ")
(print (equal (p= p q) expected))

;;; Test 6
; p = 1
; q =  -8 + 2x + 3yx^2 + x + 0z + x^0x
(setq p '((1 (()))))
(setq q '((-8 (())) (2 ((x 1))) (3 ((y 1) (x 2))) (1 ((x 1))) (0 ((z 1))) (1 ((x 0) (x 1)))))

;; Test Description:
;; Check that we can perform operations with 1 on both sides of each operator
;; Tests 6.1 - 6.3: 1 on left side
;; Tests 6.4 - 6.6: 1 on right side

;; Test 6.1
(setq expected '((-7 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "6.1: ")
(print (p= (p+ p q) expected))

;; Test 6.2
(setq expected '((9 (())) (-4 ((x 1))) (-3 ((y 1) (x 2)))))
(prin "6.2: ")
(print (p= (p- p q) expected))

;; Test 6.3
(setq expected '((-8 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "6.3: ")
(print (p= (p* p q) expected))

;; Test 6.4
(setq expected '((-7 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "6.4: ")
(print (p= (p+ q p) expected))

;; Test 6.5
(setq expected '((-9 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "6.5: ")
(print (p= (p- q p) expected))

;; Test 6.6
(setq expected '((-8 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "6.6: ")
(print (p= (p* q p) expected))

;;; Test 7
; p = -1
; q =  -8 + 2x + 3yx^2 + x + 0z + x^0x
(setq p '((-1 (()))))
(setq q '((-8 (())) (2 ((x 1))) (3 ((y 1) (x 2))) (1 ((x 1))) (0 ((z 1))) (1 ((x 0) (x 1)))))

;; Test Description:
;; Check that we can perform operations with -1 on both sides of each operator
;; Tests 7.1 - 7.3: -1 on left side
;; Tests 7.4 - 7.6: -1 on right side

;; Test 7.1
(setq expected '((-9 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "7.1: ")
(print (p= (p+ p q) expected))

;; Test 7.2
(setq expected '((7 (())) (-4 ((x 1))) (-3 ((y 1) (x 2)))))
(prin "7.2: ")
(print (p= (p- p q) expected))

;; Test 7.3
(setq expected '((8 (())) (-4 ((x 1))) (-3 ((y 1) (x 2)))))
(prin "7.3: ")
(print (p= (p* p q) expected))

;; Test 7.4
(setq expected '((-9 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "7.4: ")
(print (p= (p+ q p) expected))

;; Test 7.5
(setq expected '((-7 (())) (4 ((x 1))) (3 ((y 1) (x 2)))))
(prin "7.5: ")
(print (p= (p- q p) expected))

;; Test 7.6
(setq expected '((8 (())) (-4 ((x 1))) (-3 ((y 1) (x 2)))))
(prin "7.6: ")
(print (p= (p* q p) expected))

;;; Test 8
; p = 3yx^2 + 2z^2x^3y
; q = 2x^3yz^2 + 3x^2y
(setq p '((3 ((y 1) (x 2))) (2 ((z 2) (x 3) (y 1)))))
(setq q '((2 ((x 3) (y 1) (z 2))) (3 ((x 2) (y 1)))))

;; Test Description:
;; A more thorough version of Test 4.
;; To test all operators, since p and q are equal, but their variables and terms are not in the same order.

;; Test 8.1
(setq expected t)
(prin "8.1: ")
(print (equal (p= p q) expected))
 
;; Test 8.2
(setq expected '((6 ((y 1) (x 2))) (4 ((z 2) (x 3) (y 1)))))
(prin "8.2: ")
(print (p= (p+ p q) expected))

;; Test 8.3
(setq expected '())
(prin "8.3: ")
(print (equal (p- p q) expected))

;; Test 8.4
(setq expected '((12 ((y 2) (x 5) (z 2))) (9 ((y 2) (x 4))) (4 ((z 4) (x 6) (y 2)))))
(prin "8.4: ")
(print (p= (p* p q) expected))
