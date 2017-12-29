;;;
;;; srfi-149-mod test
;;;

(add-load-path "." :relative)
(use gauche.test)

(test-start "srfi-149-mod")
(use srfi-149-mod)
(test-module 'srfi-149-mod)

;; ----------------------------------------
(test-section "sample case")

(define-syntax add
  (syntax-rules ()
    ((_ x1 ...)
     (+ x1 ...))))

(test* "sample-case-1" 15 (add 1 2 3 4 5))
(test* "sample-case-2" '(+ '1 '2 '3 '4 '5) (macroexpand-all '(add 1 2 3 4 5)))

;; ----------------------------------------
(test-section "generate literals (bug in v1.04)")

(define-syntax gen-lit-1
  (syntax-rules ()
    ((_ lit x1 y1 z1)
     (let-syntax
         ((mac-sub1
           (syntax-rules (lit)
             ((_ x2 y2 z2)
              (+ x2 y2 z2)))))
       (mac-sub1 x1 y1 z1)))))

(test* "generate-literals-1" 6 (gen-lit-1 x2 1 2 3))

;; ----------------------------------------
(test-section "ellipsis and literals (bug in v1.06)")

;; literal has priority to ellipsis
(define-syntax elli-lit-1
  (syntax-rules ... (...)
    ((_ x)
     '(x ...))))

(test* "ellipsis-literals-1" '(100 ...) (elli-lit-1 100))

(test-end)

