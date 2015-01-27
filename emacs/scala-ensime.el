
(add-to-list 'load-path "~/ensime-emacs/")
(require 'ensime)

;; Give SBT some power
(setenv "JVM_OPTS"
"-Dfile.encoding=UTF8 -XX:MaxPermSize=1g -Xms1g -Xmx2g -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC")

;; Scala mode
(add-to-list 'load-path "~/scala-mode2/")
(require 'scala-mode2)

;; ENSIME
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
;;(add-to-list 'auto-mode-alist '("\\.console$" . scala-mode))

(defun parent-directory (dir)
  (when (endp (member dir '("~" "/" "~/")))
    (file-name-directory (directory-file-name dir))))

(defun is-project-file (full-file-name) "Find out if file is in the sbt project dir (== project)"
  (string= (file-name-nondirectory (substring (file-name-directory full-file-name) 0 -1)) "project"))

(defun is-ensime-file (path) ""
  (if (endp (directory-files path nil "\.ensime$"))
      (let ((parent (parent-directory path)))
        (if parent (is-ensime-file parent) nil))
      t))

(defun find-if-ensime () "find out if in ensime project"
  (interactive)
  (let ((current-file (buffer-file-name)))
    (if (and current-file (file-exists-p current-file)) (is-ensime-file (parent-directory current-file)) nil)))

(defun find-ensime-cofnig-file () ""
  (interactive)
  (message "%s" (ensime-config-find-file (buffer-file-name))))


(defun ensime-delete-port-file ()
  (let* ((config-file (ensime-config-find-file (buffer-file-name)))
         (config (ensime-config-load config-file))
         (cache-dir (file-name-as-directory (plist-get config :cache-dir)))
         (port-file (concat cache-dir "port")))
    (delete-file port-file)))

;;(setq scala-mode-hook nil)
(add-hook 'scala-mode-hook
          '(lambda ()
             (unless (find-if-ensime) (message "No ensime file detected"))
             (when (find-if-ensime)
               (progn
                 (unless (ensime-connected-p) ;; (buffer-file-name)
                   (message "Ensime not running for %s" (ensime-connected-p)))
                   ;;(ensime--2 (ensime-config-find-file (buffer-file-name)))) ;; TODO: Try to find ensime file and use it, if not drop it.
                 (ensime-mode)))
             ;;(yas-minor-mode)
             (subword-mode 1)))

;;             (local-set-key (kbd "RET")
;;                            '(lambda ()
;;                               (interactive)
;;                               (newline-and-indent)
;;                               (scala-indent:insert-asterisk-on-multiline-comment)))

;             (local-set-key (kbd "C-M-j") 'join-line)

             ;; Bind the backtab (shift tab) to
             ;; 'scala-indent:indent-with-reluctant-strategy command. This is usefull
             ;; when using the 'eager' mode by default and you want to "outdent" a
             ;; code line as a new statement.
;             (local-set-key (kbd "<backtab>") 'scala-indent:indent-with-reluctant-strategy)

(defun restart-server ()
  (interactive)
  (ensime-sbt-switch)
  (ensime-sbt-action "restart"))

(defun db-run ()
  (interactive)
  (ensime-sbt-switch)
  (ensime-sbt-action "db"))

(defun reload-sbt ()
  (interactive)
  (ensime-sbt-switch)
  (ensime-sbt-action "reload"))

(defun sbt-test ()
  (interactive)
  (ensime-sbt-switch)
  (ensime-sbt-action "test"))

(defun ensime-generate ()
  (interactive)
  (ensime-sbt-switch)
  (ensime-sbt-action "ensime generate -s"))

(global-set-key (kbd "s-r") 'restart-server)
(global-set-key (kbd "s-d") 'db-run)
;;(global-unset-key (kbd "s-y"))
;;(global-set-key (kbd "s-y") ')

(global-unset-key (kbd "s-t"))
(global-set-key (kbd "s-t") 'sbt-test)


(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))

;; prøv å gjøre dette bedre...
(defun ensime-servers ()
  (interactive)
  (delq nil (mapcar (lambda (b) (if (string-prefix-p "*inferior-ensime-server" (buffer-name b)) b nil)) (buffer-list)))
)

(defun find-workspace (buffer)
  (with-current-buffer buffer
    (progn
      (beginning-of-buffer)
      (let ((res (re-search-forward "Set current project to root--ensime")))
        (message "ff::: %s||" res)
        (if res
            (buffer-substring-no-properties res (re-search-forward "$"))
          nil)))))

(defun is-ensime-running-for-file (file)
  "Returning the root dir if yes, nil if no ensime server running"
  (let* ((ensime-servers (mapcar 'find-workspace (ensime-servers))))
    (delq nil (mapcar (lambda (b) (if (string-prefix-p b file) b nil)) ensime-servers)))
)

(defun is-empty (str) "true if empty" (if (or (string-equal str "") (string-equal str " ")) nil str ))

(defun combine-imports-2 (str) ""
  (let* ((lines (split-string str "\n"))
         (non-empty (delq nil (mapcar 'is-empty lines)))
         (first (split-string (car non-empty) "[\.]")))
    (concat (mapconcat 'identity (butlast first ) ".") ".{ " (car (last first)) ", "
    (mapconcat (lambda (b) (car (last (split-string b "[\.]")))) (cdr non-empty) ", " ) " }")
    ))

(defun combine-imports (a b) ""
  (interactive "r")
  (let (beg end nl)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end) nl (bolp))
      (setq beg (line-beginning-position) end (+ 1 (line-end-position)) nl nil))
    (insert (combine-imports-2 (delete-and-extract-region beg end )))
    (insert (if nl "\n" ""))))

(defun split-imports-2 (str) ""
  (let* ((parts (split-string str "[{}]"))
         (main (substring (car parts) 0 -1))
         (elems (split-string (cadr parts))))
    (mapconcat (lambda (b) (concat main "." (car (split-string b "[,]")))) elems "\n" )
    ))

(fset 'ignore-import
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([left 123 32 33554464 41 backspace 41 40 backspace backspace 41 61 backspace backspace 41 backspace 61 62 32 95 44 32 right 125 left 32 right left left left left left left left left left left left right] 0 "%d")) arg)))

(defun split-imports (a b) ""
  (interactive "r")
  (let (beg end nl)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end) nl (bolp))
      (setq beg (line-beginning-position) end (+ 1 (line-end-position)) nl nil))
    (insert (split-imports-2 (delete-and-extract-region beg end )))
    (insert (if nl "\n" ""))))

(defun extract-package ()
  (interactive)
  (let* ((dir default-directory)
         (pname (replace-regexp-in-string "\/" "." dir)))
    (insert (concat "packate " pname))))

(global-set-key (kbd "C-c p") 'extract-package)

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
