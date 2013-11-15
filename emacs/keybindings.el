(global-unset-key "\C-c\C-u")
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-unset-key "\C-c\C-c")
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key (kbd "C-x '") 'next-error)
(global-set-key "\C-c\C-u" 'uncomment-region)

(setq mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

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
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-<") 'mc/mark-next-like-this)
(global-set-key (kbd "C->") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-å") 'mc/mark-sgml-tag-pair)

;; sbt-console
(global-unset-key [C-tab])
(global-unset-key "\C-c\C-q")
(global-unset-key "\C-c\C-e")

(global-set-key [C-tab] 'send-tab-to-console)
(global-set-key (kbd "C-å") 'send-to-console)
(global-set-key "\C-c\C-q" 'console-quick)
(global-set-key "\C-c\C-e" 'send-to-console)


