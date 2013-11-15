(defun console-quick ()
  "send command to sbt console"
  (interactive)
  (process-send-string "sbt" "console-quick\n")
)

(defun console-paste ()
  "send command to sbt console"
  (interactive)
  (process-send-string "sbt" ":paste\n")
)

(defun send-to-console (beg end)
  "send command to sbt console"
  (interactive "r")
  (process-send-string "sbt" (replace-regexp-in-string "\t" "    " (buffer-substring beg end)))
)

(defun send-tab-to-console ()
  ""
  (interactive)
  (process-send-string "sbt" "\t")
)

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
