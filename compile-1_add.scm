
;; for srfi-149-mod

(define (pass1/syntax-quote obj)
  ($const obj))

(define-pass1-syntax (syntax-quote form cenv) :null
  (match form
    [(_ obj) (pass1/syntax-quote obj)]
    [else (error "syntax-error: malformed syntax-quote:" form)]))

