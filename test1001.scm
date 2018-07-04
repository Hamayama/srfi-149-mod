;;;
;;; srfi-149-mod test
;;;

(add-load-path "." :relative)
(use gauche.test)

(test-start "srfi-149-mod")
(use srfi-149-mod)
(test-module 'srfi-149-mod)

;; ----------------------------------------
(test-section "simple case")

(define-syntax add
  (syntax-rules ()
    ((_ x1 ...)
     (+ x1 ...))))

(test* "simple-case-1" 15 (add 1 2 3 4 5))
(test* "simple-case-2" '(+ '1 '2 '3 '4 '5) (macroexpand-all '(add 1 2 3 4 5)))

;; ----------------------------------------
(test-section "generate literals (fixed in v1.05)")

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
(test-section "ellipsis and literals (fixed in v1.07)")

;; literal has priority to ellipsis (R7RS 4.3.2)
(define-syntax elli-lit-1
  (syntax-rules ... (...)
    ((_ x)
     '(x ...))))

(test* "ellipsis-literals-1" '(100 ...) (elli-lit-1 100))

;; ----------------------------------------
(test-section "bad ellipsis (fixed in v1.08)")

(test* "bad-ellipsis-1"
       (test-error)
       (eval
        '(define-syntax bad-elli-1
           (syntax-rules ()
             ((_ ... x)
              '(... x))))
        (interaction-environment)))

(test* "bad-ellipsis-2"
       (test-error)
       (eval
        '(define-syntax bad-elli-2
           (syntax-rules ()
             ((_ (... x))
              '(... x))))
        (interaction-environment)))

;; ----------------------------------------
(test-section "ellipsis escape (fixed in v1.10-1.13)")

(define-syntax elli-esc-1
  (syntax-rules ()
    ((_)
     '(... ...))
    ((_ x)
     '(... (x ...)))
    ((_ x y)
     '(... (... x y)))))

(test* "ellipsis-escape-1" '... (elli-esc-1))
(test* "ellipsis-escape-2" '(100 ...) (elli-esc-1 100))
(test* "ellipsis-escape-3" '(... 100 200) (elli-esc-1 100 200))

(define-syntax elli-esc-2
  (syntax-rules ()
    ((_)
     '(...))
    ((_ x)
     '(... x))
    ((_ x y)
     '(... x y))))

(test* "ellipsis-escape-4" '() (elli-esc-2))
(test* "ellipsis-escape-5" 100 (elli-esc-2 100))
(test* "ellipsis-escape-6" '(100 200) (elli-esc-2 100 200))

(test-end)

