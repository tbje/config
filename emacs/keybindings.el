(global-unset-key "\C-c\C-u")
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-unset-key "\C-c\C-c")
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key (kbd "C-x '") 'next-error)
(global-set-key "\C-c\C-u" 'uncomment-region)
(global-unset-key "\C-x\C-z")

(when (eq system-type 'gnu/linux)
   ;;(setq x-super-keysym 'meta) ;; Use windows as meta
   ;;(setq x-meta-keysym 'super) ;; Use alt as super
)

(when (eq system-type 'darwin)
   ;; (setq mac-option-modifier nil
   ;;       mac-command-modifier 'meta
   ;;       mac-right-command-modifier 'super
   ;;       mac-right-control-modifier 'super
   ;;       mac-right-option-modifier 'super
   ;;       x-select-enable-clipboard t))
   ;; (setq mac-option-modifier nil
   ;;       mac-command-modifier 'meta
   ;;       x-select-enable-clipboard t)
   (setq mac-option-key-is-meta t)
   ;; To be able to write {} on norwegian keyboard.
   (setq mac-right-option-modifier nil)
)


(global-set-key (kbd "M-_") 'hippie-expand)

(global-set-key (kbd "s-1") 'facelift-txt-to-definintion)

;; from case-util
(global-set-key (kbd "C-æ") 'upcase-char)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(global-set-key (kbd "C-c C-v q") 'ensime-mode)

(defun insert-implicit-session () ""
  (interactive)
  (insert " implicit s: Session =>")
)

(global-set-key (kbd "C-c C-v i") 'insert-implicit-session)

(defun insert-facelift-imports () ""
  (interactive)
  (insert "import com.github.tbje.facelift.imports._")
)



(global-set-key (kbd "C-c C-v i") 'insert-implicit-session)
(global-set-key (kbd "C-c C-p f") 'insert-facelift-imports)
(global-set-key (kbd "C-c C-p s") 'split-imports)
(global-set-key (kbd "C-c C-p c") 'combine-imports)
(global-set-key (kbd "C-c C-p i") 'ignore-import)
(global-set-key (kbd "C-c C-p e") 'ediff-current-file)


;; git-backup
(global-unset-key "\C-b")
(global-unset-key "\C-b\C-b")
(global-unset-key "\C-b\C-r")
(global-set-key "\C-b\C-b" 'backup-for-git)
(global-set-key "\C-b\C-r" 'recover-for-git)

;; multi-cursors
(global-set-key (kbd "s-ø") 'mc/edit-lines)
(global-set-key (kbd "s-æ") 'mc/mark-all-like-this)
(global-set-key (kbd "s-å") 'mc/mark-sgml-tag-pair)

; When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer, use:
(global-set-key (kbd "s--") 'mc/mark-next-like-this)
(global-set-key (kbd "s-_") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-å") 'mc/mark-sgml-tag-pair)
(global-set-key (kbd "s-@") 'mc/mark-pop)

;; sbt-console
(global-unset-key [C-tab])
(global-unset-key "\C-c\C-q")
(global-unset-key "\C-c\C-e")

(global-set-key [C-tab] 'send-tab-to-console)
(global-set-key (kbd "C-å") 'send-to-console)
(global-set-key (kbd "C-<") 'send-to-console)
(global-set-key (kbd "C-z") 'send-to-console)
(global-set-key "\C-c\C-q" 'console-quick)
(global-unset-key (kbd "s-z"))
(global-set-key (kbd "s-z") 'zermex-console)
(global-set-key "\C-c\C-e" 'send-to-console)

(global-set-key (kbd "s-.") 'swap-windows)
;; move-text
(require 'move-text)
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

(global-unset-key (kbd "s-b"))

(global-set-key (kbd "s-b") 'toggle-fullscreen)

(global-unset-key (kbd "s-k"))
(global-set-key (kbd "s-k") 'ruthlessly-kill-line)

(require 'smooth-scroll)
(global-set-key (kbd "s-ø") 'scroll-down-1)
(global-set-key (kbd "s-æ") 'scroll-up-1)
