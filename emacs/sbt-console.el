(defun sbt-send (what)
  "send somthing to sbt process"
  (process-send-string "sbt" what)
)

(defun console-quick ()
  "send command to sbt console"
  (interactive)
  (sbt-send "console-quick\n")
)


(defun sbt-console ()
  "send command to sbt console"
  (interactive)
  (ensime-sbt)
  (console)
)

(defun zermex-console ()
  "send command to sbt console"
  (interactive)
  (console)
  (sbt-send ":load js\n")
)

(defun console-paste ()
  "send command to sbt console"
  (interactive)
  (sbt-send ":paste\n")
)

(defun ensime-sbt-do-console ()
  (interactive)
  (sbt-command "console"))

(defun ensime-sbt-do-restart ()
  (interactive)
  (sbt-command "restart"))

(defun koan-next ()
  (interactive)
  (sbt-command "koan next"))

(defun test ()
  (interactive)
  (sbt-command "test"))

(defun compile-s ()
  (interactive)
  (sbt-command "compile"))

(defun native ()
  (interactive)
  (sbt-command "nativeLink"))

(defun send-to-console ()
  "send command to sbt console"
  (interactive)
  (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (+ 1 (line-end-position))))
        (sbt:send-region beg end)))

(defun send-tab-to-console ()
  ""
  (interactive)
  (sbt-send "\t")
)

(defun send-enter-to-console ()
  ""
  (interactive)
  (sbt:clear)
)


(defun console-exit-paste ()
  ""
  (interactive)
  (sbt-send "\z")
)

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
   White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
   White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)

(defun extract-types () ""
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (+ 1 (line-end-position))))
    (kill-new (extract-types-x (buffer-substring beg end)))))

(defun extract-types-x (str) ""
(let* ((in-parens (apply 'concat (cdr (split-string str "("))))
  (new (split-string in-parens ","))
  (strings (mapcar (lambda (x) (car (split-string (trim-string (cadr (split-string x ":"))) "[ |[]")) ) new))
  (rev (reverse strings))
  (first (reverse (cdr rev)))
  (last (car rev)))
  (concat (apply 'concat (mapcar (lambda (x) (concat x ", ")) first)) last)
))


;; (defun send-to-console (beg end)
;;   "send command to sbt console"
;;   (interactive "r")
;;   (process-send-region "sbt" beg end)
;; )

;;(defun go-to-sbt-console (beg end)
;;  "send command to sbt console"
;;  (interactive)
;;  (mapcar (function buffer-name) (buffer-list))
;;  (switch-to-buffer ("sbt" (replace-regexp-in-string "\t" "    " (buffer-substring beg end)))
;;)
