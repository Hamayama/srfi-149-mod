(add-load-path "." :relative)
(use srfi-149-mod)

(define-syntax add
  (syntax-rules ()
    ((_ x1 ...)
     (+ x1 ...))))

(print "(add 1 2 3 4 5) = " (add 1 2 3 4 5))

(print "macroexpand-all : " (macroexpand-all '(add 1 2 3 4 5)))

