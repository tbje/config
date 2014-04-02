(defun sbt-send (what) 
  "send somthing to sbt process" 
  (process-send-string "sbt" what)
)
 
(defun console-quick ()
  "send command to sbt console"
  (interactive)
  (sbt-send "console-quick\n")
)

(defun console ()
  "send command to sbt console"
  (interactive)
  (sbt-send "console\n")
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

(defun send-to-console ()
  "send command to sbt console"
  (interactive)
  (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (+ 1 (line-end-position))))
        (sbt-send (replace-regexp-in-string "\t" "    " (buffer-substring beg end)))
))

(defun send-tab-to-console ()
  ""
  (interactive)
  (sbt-send "\t")
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
