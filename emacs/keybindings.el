(global-unset-key "\C-c\C-u")
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-unset-key "\C-c\C-c")
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key (kbd "C-x '") 'next-error)
(global-set-key "\C-c\C-u" 'uncomment-region)

(setq x-super-keysym 'meta) ;; Use windows as meta
(setq x-meta-keysym 'super) ;; Use alt as super


;(setq mac-option-modifier nil
;      mac-command-modifier 'meta
;      x-select-enable-clipboard t)

(global-set-key (kbd "M-_") 'hippie-expand)

;; from case-util
(global-set-key (kbd "C-æ") 'upcase-char)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; git-backup
(global-unset-key "\C-b")
(global-unset-key "\C-b\C-b")
(global-unset-key "\C-b\C-r")
(global-set-key "\C-b\C-b" 'backup-for-git)
(global-set-key "\C-b\C-r" 'recover-for-git)

;; multi-cursors
;(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
;(global-set-key (kbd "C->") 'mc/mark-previous-like-this)
(global-set-key (kbd "s-ø") 'mc/edit-lines)
(global-set-key (kbd "s-æ") 'mc/mark-all-like-this)
(global-set-key (kbd "s-å") 'mc/mark-sgml-tag-pair)

; When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer, use:
(global-set-key (kbd "s--") 'mc/mark-next-like-this)
(global-set-key (kbd "s-_") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-å") 'mc/mark-sgml-tag-pair)

;; sbt-console
(global-unset-key [C-tab])
(global-unset-key "\C-c\C-q")
(global-unset-key "\C-c\C-e")

(global-set-key [C-tab] 'send-tab-to-console)
(global-set-key (kbd "C-å") 'send-to-console)
(global-set-key "\C-c\C-q" 'console-quick)
(global-set-key "\C-c\C-e" 'send-to-console)

;; move-text
(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)

;; expand-region
(global-set-key (kbd "C-.") 'er/expand-region)

(global-set-key (kbd "s-e") 'send-to-mysql)

;;(global-set-key (kbd "s-t") '(lambda () (interactive) (ansi-term "/bin/bash"))) 
(global-set-key (kbd "M-SPC") 'hippie-expand)


(global-unset-key "\C-c\C-u")
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-unset-key "\C-c\C-c")
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key (kbd "C-x '") 'next-error)
(global-set-key "\C-c\C-u" 'uncomment-region)

(global-set-key (kbd "s-g") 'rgrep)

(global-set-key (kbd "C-'") 'er/expand-region)

;; (global-set-key (kbd "s-tab") 'org-)

(global-set-key (kbd "s-o") 'wrap-in-option)
(global-set-key (kbd "s-'") 'wrap-in-string)
(global-set-key (kbd "s-i") 'wrap-in-interpol)
(global-set-key (kbd "<s-down>") 'enlarge-window)
(global-set-key (kbd "<s-up>") 'shrink-window)
(global-set-key (kbd "<s-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<s-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-n") 'nav)

(global-set-key (kbd "s-f") 'find-file-at-point-with-line)

(global-set-key (kbd "s-q") 'kill-this-buffer-volatile) ;; find new 

