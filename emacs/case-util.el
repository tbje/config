(defun upcase-char ()
  (interactive)
  (upcase-region
   (point)
   (+ (point) 1)))


(defun yank-word (&optional arg)
      "Copy words at point into kill-ring"
       (interactive "P")
       (copy-thing 'backward-word 'forward-word arg)
       ;;(paste-to-mark arg)
)

(defun un-camelcase-word-at-point ()
  "un-camelcase the word at point, replacing uppercase chars with the lowercase version preceded by an underscore.
   The first char, if capitalized (eg, PascalCase) is just downcased, no preceding underscore."
  (interactive)
  (progn (replace-regexp "\\([A-Z]\\)" "_\\1" nil (region-beginning)(region-end))
         (downcase-region (region-beginning)(region-end))))

(defun camelize (string is-method)
      "Convert under-score string S to camelCase string."
      (mapconcat 'identity 
        (let* ((c (split-string string "-"))
              (first (if is-method (car c) ()))
              (rest (if is-method (cdr c) c)))
          (cons first (mapcar
           '(lambda (word) (capitalize (downcase word)))
           rest))) ""))

(defun camelize-class (beg end)
  (interactive "r")
  (let ((c (camelize (buffer-substring beg end) nil)))
    (delete-region beg end)
    (goto-char beg)
    (insert c)))

(defun camelize-method (beg end)
  (interactive "r")
  (let ((c (camelize (buffer-substring beg end) t)))
    (delete-region beg end)
    (goto-char beg)
    (insert c)))
