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

(defun term-send-del   () (interactive) (term-send-raw-string "\e[3~"))
(defun term-send-backspace  () (interactive) (term-send-raw-string "\C-?"))

(global-unset-key (kbd "<f8>"))
(global-set-key (kbd "<f8>") 'toggle-char-line-mode)
