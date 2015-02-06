(global-unset-key (kbd "C-c C-u"))
(global-unset-key (kbd "C-c C-c"))
(global-unset-key (kbd "C-x C-z"))
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-x '") 'next-error)

(defun shut-down-cmd () "" (interactive)(shell-command "power-off"))

(global-set-key (kbd "C-c C-q") 'shut-down-cmd)
(global-set-key (kbd "C-c C-d p") 'ensime-sbt-do-compile)

(global-set-key (kbd "C-c g") 'google)
(global-set-key (kbd "C-c b") 'helm-bookmarks)
(global-set-key (kbd "C-c c") 'find-config)
(global-set-key (kbd "C-c f") 'helm-find-files)
(global-set-key (kbd "C-c w") 'eww)
(global-set-key (kbd "C-c i") 'helm-scala-complete)
(global-set-key (kbd "C-c e") 'eshell)
(global-set-key (kbd "C-c p") 'helm-browse-project)
(global-set-key (kbd "M-x") 'helm-M-x)

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

(defun find-fast-term (active start end) ""
  (if active (buffer-substring-no-properties start end) (read-from-minibuffer "Search for: ")))

(defun find-fast (start end) ""
  (interactive "r")
    (rgrep (find-fast-term (region-active-p) start end) "*.scala" "~/zermex-site"))

(global-set-key (kbd "<f6>") 'find-fast)

(global-set-key (kbd "M-_") 'hippie-expand)

(global-set-key (kbd "s-1") 'facelift-txt-to-definintion)

;; from case-util
(global-set-key (kbd "C-æ") 'upcase-char)
(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

(global-set-key (kbd "C-c C-v q") 'ensime-mode)
(global-set-key (kbd "C-c C-p s") 'split-imports)
(global-set-key (kbd "C-c C-p c") 'combine-imports)
(global-set-key (kbd "C-c C-p i") 'ignore-import)
(global-set-key (kbd "C-c C-p e") 'ediff-current-file)
(global-set-key (kbd "C-c C-e") 'eval-and-replace)

;; git-backup
(global-unset-key (kbd "C-b")
(global-unset-key (kbd "C-b C-b"))
(global-unset-key (kbd "C-b C-r"))
(global-set-key (kbd "C-b C-b") 'backup-for-git)
(global-set-key (kbd "C-b C-r") 'recover-for-git)

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

(global-set-key [C-tab] 'send-tab-to-console)
(global-set-key (kbd "C-å") 'send-to-console)
(global-set-key (kbd "C-<") 'send-to-console)
(global-set-key (kbd "C-z") 'send-to-console)
(global-set-key "\C-c\C-q" 'console-quick)
(global-unset-key (kbd "s-z"))
(global-set-key (kbd "s-z") 'console-quick)

(global-unset-key (kbd "<f10>"))
(global-unset-key (kbd "<f11>"))
(global-unset-key (kbd "<f12>"))
(global-set-key (kbd "<f10>") 'bufshow-prev)
(global-set-key (kbd "<f11>") 'bufshow-next)
(global-set-key (kbd "<f12>") 'toggle-read-only)

;;(global-set-key (kbd "s-z") 'zermex-console)
(global-set-key (kbd "s-z") 'ensime-sbt)

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

(global-unset-key (kbd "C-c C-c"))
(global-unset-key (kbd "C-c C-u"))
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)
(global-set-key (kbd "C-x '") 'next-error)

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


(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "<f6>") 'scala-rgrep)
(global-set-key (kbd "M-<f6>") 'play-template-rgrep)
(global-set-key (kbd "M-<f7>") 'case-class-rgrep)
(global-set-key (kbd "s-<f6>") 'js-rgrep)
(global-set-key (kbd "<f12>") 'toggle-read-only)
(global-set-key (kbd "M-<f11>") 'other-frame-or-create)

(defun other-frame-or-create () "Moves to the other frame or creates one if only one frame"
       (interactive)
       (let ((frames (frame-list)))
         (if (eq 1 (length frames)) (make-frame) (other-frame 1))))

(defun find-string-for-search (active start end) ""
       (interactive)
       (if active
           (buffer-substring-no-properties start end)
         (read-from-minibuffer "Search for: ")))

(defun case-class-rgrep (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (let ((search (find-string-for-search (region-active-p) start end)))
    (rgrep (concat "case class " search "[ (]") "*.scala" "~/teleios")
    (switch-to-buffer-other-frame "*grep*")
    (set-process-sentinel (get-buffer-process (current-buffer)) 'next-error)))

(defun next-error-and-close (a b)
  (let ((b (current-buffer)))
    (next-error)
    (kill-buffer b)))

(defun scala-rgrep (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (let ((search (find-string-for-search (region-active-p) start end)))
    (rgrep search "*.scala" "~/teleios")))

(defun play-template-rgrep (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (let ((search (find-string-for-search (region-active-p) start end)))
    (rgrep search "*.scala.html" "~/teleios/teleios-advisor-web/app")))

(defun js-rgrep (start end)
  "Print number of lines and characters in the region."
  (interactive "r")
  (let ((search (find-string-for-search (region-active-p) start end)))
    (message search)
    (rgrep search "*.js" "~/teleios/teleios-advisor-web/app")))
