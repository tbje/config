(require 'tramp)

(defun su-edit ()
  "edit as su - jumping to same position"
  (interactive)
  (let ((position (point)))
    (find-file (concat "/sudo::" (buffer-file-name)))
    (goto-char position)))

(defun su-find-file (f)
  "nice to use with bookmark+, i.e. (file-handler . su-find-file) will open the file as su"
  (with-current-buffer
      (find-file f)
    (su-edit)))
