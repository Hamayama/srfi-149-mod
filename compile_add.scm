
;; for srfi-149-mod

(select-module gauche.internal)

;; (overwrite the above definition)
;; er-comparer :: (Sym-or-id, Sym-or-id, Env, Env) -> Bool
(define (er-comparer a b uenv cenv)
  (cond
   ;; consider keywords
   ((and (keyword? a) (keyword? b))
    (eq? a b))
   (else
    (and (variable? a)
         (variable? b)
         ;; recognize both variables and macros
         (let ([a1 (cenv-lookup-syntax uenv a)]
               [b1 (cenv-lookup-syntax uenv b)])
           (or (eq? a1 b1)
               (free-identifier=? a1 b1)))))))

