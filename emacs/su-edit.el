(require 'tramp)

(defun su-edit ()
  (interactive)
  (let ((position (point)))
    (find-file (concat "/sudo::" (buffer-file-name)))
    (goto-char position)))
