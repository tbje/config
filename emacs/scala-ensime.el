;; Scala mode
(add-to-list 'load-path "~/scala-mode/")
(require 'scala-mode-auto)

;; ENSIME
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.console$" . scala-mode))

(add-to-list 'load-path "~/ensime/dist/elisp/")
(require 'ensime)

(defun parent-directory (dir)
  (when (endp (member dir '("~" "/" "~/")))
    (file-name-directory (directory-file-name dir))))

(defun is-ensime-file (path) "" 
  (if (endp (directory-files path nil "\.ensime$"))
      (let ((parent (parent-directory path)))
        (if parent (is-ensime-file parent) nil))
      t)    
)

(defun find-if-ensime () "find out if in ensime project"
  (interactive)
  (message "find is ensime running on %s %s" (buffer-name) (buffer-file-name))
  (let ((current-file (buffer-file-name)))
    (if (and current-file (file-exists-p current-file)) (is-ensime-file (parent-directory current-file)) nil))
)

(add-hook 'scala-mode-hook
          '(lambda ()
             ;; Alternatively, bind the 'newline-and-indent' command and
             ;; 'scala-indent:insert-asterisk-on-multiline-comment' to RET in
             ;; order to get indentation and asterisk-insertion within multi-line
             ;; comments.
             (unless (find-if-ensime) (message "No ensime file detected"))
             (when (find-if-ensime) (ensime-mode 1))
             (yas/minor-mode-on)
             (subword-mode 1)
;;             (local-set-key (kbd "RET")
;;                            '(lambda ()
;;                               (interactive)
;;                               (newline-and-indent)
;;                               (scala-indent:insert-asterisk-on-multiline-comment)))
 
             ;; Bind the 'join-line' command to C-M-j. This command is normally
             ;; bound to M-^ which is hard to access, especially on some European
             ;; keyboards. The 'join-line' command has the effect or joining the
             ;; current line with the previous while fixing whitespace at the
             ;; joint.
;             (local-set-key (kbd "C-M-j") 'join-line)
 
             ;; Bind the backtab (shift tab) to
             ;; 'scala-indent:indent-with-reluctant-strategy command. This is usefull
             ;; when using the 'eager' mode by default and you want to "outdent" a
             ;; code line as a new statement.
;             (local-set-key (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)
             ))


;; prøv å gjøre dette bedre...
(defun ensime-servers () 
(interactive)
(delq nil (mapcar (lambda (b) (if (string-prefix-p "*inferior-ensime-server" (buffer-name b)) b nil)) (buffer-list)))
)


;;(setq special-display-function nil)
;;(setq special-display-regexps '(""))
;;(setq special-display-regexps nil)


;(setq special-display-buffer-names '("*Inspector*"))
;(setq special-display-function 'display-special-buffer)

;;(setq display-special-buffer nil)

;;(defun 
;;  (universal-coding-system-argument 
;;  set-buffer-file-coding-system

;; (defun display-special-buffer (buf &optional not-this-window)
;;   "put the special buffers in the right spot (bottom rigt)"
;;  (message "Special buffer")
;;  ;;(message (window-list))
;;  (if (eq (window-at 2 2) (window-at (- (frame-width) 4) 2)) 
;;    (split-window-horizontally -30)
;;  )
;;     (let ((target-window (window-at (- (frame-width) 4) 2))
;;           (pop-up-windows t))
;;       (set-window-buffer target-window buf)
;;       target-window))

;; (defun my-display-buffer (buf &optional not-this-window)
;;   "put all buffers in a window other than the one in the bottom right"
;;   (message (buffer-name  buf))
;;   (if (string= (buffer-name buf) "*Inspector*")
;;       (display-special-buffer buf)
;;       (progn
;;         (let ((pop-up-windows nil)
;;                   (windows (delete (window-at (- (frame-width) 4) 40)
;;                          (delete (minibuffer-window) (window-list))
;;          )))
;;           (message (buffer-name (window-buffer (car windows))))
;;           (set-window-buffer (car (cdr windows)) buf)
;;           (car (cdr windows))))))
