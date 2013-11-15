(set-variable 'inferior-lisp-program "~/clojurescript/script/browser-repl")
(set-variable 'inferior-lisp-program "~/clojurescript/script/repl")

(setq tbje/untabify-modes '(scala-mode clojure-mode))

(defun tbje/untabify-hook ()
  (when (member major-mode tbje/untabify-modes)
    (message "Tabifying")
    (untabify (point-min) (point-max))
    (when (member major-mode '(scala-mode))
      (let ((minor-modes minor-mode-alist)
        (locals (buffer-local-variables)))
          (while minor-modes
      	    (let* ((minor-mode (car (car minor-modes)))
      	       (indicator (car (cdr (car minor-modes))))
      	       (local-binding (assq minor-mode locals)))
      	  ;; Document a minor mode if it is listed in minor-mode-alist,
      	  ;; bound locally in this buffer, non-nil, and has a function
      	  ;; definition.
      	  (if (and local-binding
      		   (cdr local-binding)
      		   (fboundp minor-mode))
      	      (progn
      		(message (format "\n\n\n%s minor mode (indicator%s):\n"
      			       minor-mode indicator))
              )
              (progn 
                (message minor-mode))
            )
          )
          (setq minor-modes (cdr minor-modes))
        )
       )
      )
    )
)      

;       (message "Format scala")
;       (unwind-protect
;         (ensime-format-source) 
;         t
;       )
;     )
;  )
;)

;(add-hook 'before-save-hook 'tbje/untabify-hook)

;; (add-hook 'before-save-hook
;;   (lambda ()
;;     (untabify (point-min) (point-max))))

; (remove-hook 'before-save-hook)
