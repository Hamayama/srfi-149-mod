
;; for srfi-149-mod

(select-module gauche.internal)

;; (overwrite the above definition)
;; er-comparer :: (Sym-or-id, Sym-or-id, Env, Env) -> Bool
(define (er-comparer a b uenv cenv)
  (cond
   ((and (variable? a) (variable? b))
    ;; recognize both variables and macros
    (let ([a1 (cenv-lookup-syntax uenv a)]
          [b1 (cenv-lookup-syntax uenv b)])
      (or (eq? a1 b1)
          (free-identifier=? a1 b1))))
   (else
    ;; consider keywords
    (and (not (symbol? a))
         (not (symbol? b))
         (keyword? a)
         (keyword? b)
         (eq? a b)))))

