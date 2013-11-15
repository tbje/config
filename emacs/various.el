;(define-key sql-mode-map (quote [M-return]) 'sqlparser-mysql-complete)
;(define-key sql-interactive-mode-map  (quote [M-return]) 'sqlparser-mysql-complete)

(setq exec-path (append exec-path '("~/bin")))

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path))

(add-hook 'html-mode (lambda () (local-unset-key '[160])))

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

(setq jabber-account-list '('typesafe-jabber))


;(require 'todochiku)

;; (defun growl-jabber-notify (from buf text proposed-alert)
;;   "(jabber.el hook) Notify of new Jabber chat messages via growl"
;;   (when (or jabber-message-alert-same-buffer
;;             (not (memq (selected-window) (get-buffer-window-list buf))))
;;     (if (jabber-muc-sender-p from)
;;         (todochiku-message (format "(PM) %s"
;;                        (jabber-jid-displayname (jabber-jid-user from)))
;;                (format "%s: %s" (jabber-jid-resource from) text) (todochiku-icon 'compile))
;;       (todochiku-message (format "%s" (jabber-jid-displayname from))
;;              text (todochiku-icon 'compile)))))

;; (add-hook 'jabber-alert-message-hooks 'growl-jabber-notify)

;;(add-hook 'scala-mode-hook 'sub-word-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;hist mode
(savehist-mode 1)
