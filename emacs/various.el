;(define-key sql-mode-map (quote [M-return]) 'sqlparser-mysql-complete)
;(define-key sql-interactive-mode-map  (quote [M-return]) 'sqlparser-mysql-complete)

(setq exec-path (append exec-path '("~/bin")))

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:~/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path))

(add-hook 'html-mode (lambda () (local-unset-key '[160])))

(setq erc-server-history-list '("https://moxie.typesafe.com:6697"))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun save-no-hooks () "Do not remove trailing whitespaces when saving..."
  (interactive)
  (let ((before-save-hook (remove 'delete-trailing-whitespace before-save-hook))) (save-buffer)))

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


(defun auto-revert-open (f)
  (with-current-buffer (find-file f)
    (auto-revert-mode)
    (end-of-buffer)))


(require 'yasnippet)
(yas/load-directory "~/.emacs.d/snippets")

;;hist mode
(savehist-mode 1)


(defun git-logb ()
  (git-log-other (git--select-branch)))

(defun git-logob ()
  (git-log-other (git--select-remote "Select remote: ")))

(defun project ()
  (cd (concat "~/" (ido-completing-read "Project: " '("config") nil nil nil nil nil))))

(defun git-pr (br)
  "create a pull request against amc-develop"
  (concat "http://git/efgfp/teleios/compare/amc-develop..." br "?expand=1"))
