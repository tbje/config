(defun bookmark-add (&optional name parg interactivep no-update-p) ""
  (interactive (list nil current-prefix-arg t))
  (bookmark-set name parg interactivep no-update-p))
