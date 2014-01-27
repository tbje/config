;; Scala mode
(add-to-list 'load-path "~/scala-mode/")
(require 'scala-mode-auto)

;; ENSIME
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.console$" . scala-mode))
;(add-to-list 'load-path "~/ensime/dist_2.9.2/elisp/")
;(require 'ensime)

;;(add-hook 'scala-mode-hook 'sub-word-mode)

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
