(require 'tramp)

(defun su-edit ()
  "edit as su - jumping to same position"
  (interactive)
  (let ((position (point)))
    (find-file (concat "/sudo::" (buffer-file-name)))
    (goto-char position)))

(defun su-find-file (f)
  "nice to use with bookmark+, i.e. (file-handler . su-find-file) will open the file as su"
  (find-file (concat "/sudo::" f)))

(defun su-find ()
  "nice to use with bookmark+, i.e. (file-handler . su-find-file) will open the file as su"
  (interactive)
  (let ((file (car (find-file-read-args "Find file: "
                        (confirm-nonexistent-file-or-buffer)))))
    (find-file (concat "/sudo::" file))))
