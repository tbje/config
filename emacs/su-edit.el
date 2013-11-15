(require 'tramp)

(defun su-edit ()
  (interactive)  
  (find-file (concat "/sudo::" (buffer-file-name))))
