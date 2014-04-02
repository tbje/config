;(define-key sql-mode-map (quote [M-return]) 'sqlparser-mysql-complete)
;(define-key sql-interactive-mode-map  (quote [M-return]) 'sqlparser-mysql-complete)

(setq exec-path (append exec-path '("~/bin")))

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path))

(add-hook 'html-mode (lambda () (local-unset-key '[160])))

(setq erc-server-history-list '("https://moxie.typesafe.com:6697"))

(setq redisplay-dont-pause t)
(set-default 'truncate-lines t)
(setq inhibit-startup-message t)

(desktop-save-mode 1)

(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(egg-enable-tooltip t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun ruthlessly-kill-line ()
  "Deletes a line, but does not put it in the kill-ring. (kinda)"
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (if (and (eq beg end) (< end (buffer-end 1)))
        (delete-region beg (+ 1 end))
        (delete-region beg end))
))

(require 'yasnippet)
(yas/load-directory "~/.emacs.d/snippets")

;;hist mode
(savehist-mode 1)
