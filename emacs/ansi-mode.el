(set-variable 'my-ansi-char-mode t)

(defun toggle-char-line-mode () ""
  (interactive)
  (if my-ansi-char-mode
      (progn
        (setq my-ansi-char-mode nil)
        (term-char-mode))
    (progn
      (setq my-ansi-char-mode t)
      (term-line-mode))))

(global-unset-key (kbd "<f8>"))
(global-set-key (kbd "<f8>") 'toggle-char-line-mode)
