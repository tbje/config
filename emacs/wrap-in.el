
(defun wrap-in (beg end before after) ""
  (interactive "r")
  (goto-char end)
  (insert after)
  (goto-char beg)
  (insert before)
)


(defun wrap-in-option (beg end)
  "wrap some marked area in an Option[txt]"
  (interactive "r")
  (wrap-in beg end "Option[" "]")
)

(defun wrap-in-interpol (beg end)
  "wrap some marked area in an Option[txt]"
  (interactive "r")
  (wrap-in beg end "${" "}")
)

(defun wrap-in-string (beg end)
  "wrap some marked area in an Option[txt]"
  (interactive "r")
  (wrap-in beg end "\"" "\"")
)
