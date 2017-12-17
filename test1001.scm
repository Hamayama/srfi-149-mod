;;;
;;; srfi-149-mod test
;;;

(add-load-path "." :relative)
(use gauche.test)

(test-start "srfi-149-mod")
(use srfi-149-mod)
(test-module 'srfi-149-mod)

(define-syntax expr-test
  (syntax-rules ()
    ((_ txt ans expr)
     (test* (string-append txt (if (equal? txt "") "" " ")
                           ": " (format "~s" 'expr)) ans expr))
    ((_ txt ans expr chk)
     (test* (string-append txt (if (equal? txt "") "" " ")
                           ": " (format "~s" 'expr)) ans expr chk))))

(test-section "syntax-rules : normal case")

(define-syntax add
  (syntax-rules ()
    ((_ x1 ...)
     (+ x1 ...))))

(expr-test "" 15 (add 1 2 3 4 5))
(expr-test "" '(+ '1 '2 '3 '4 '5) (macroexpand-all '(add 1 2 3 4 5)))

(test-section "syntax-rules : error case on v1.04")

(define-syntax mac-main1
  (syntax-rules ()
    ((_ lit x1 y1 z1)
     (let-syntax
         ((mac-sub1
           (syntax-rules (lit)
             ((_ x2 y2 z2)
              (+ x2 y2 z2)))))
       (mac-sub1 x1 y1 z1)))))

(expr-test "" 6 (mac-main1 x2 1 2 3))

(test-end)

