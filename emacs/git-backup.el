(defun backup-for-git ()
  "backup-for-git"
  (interactive)
  (let (
    (filename (buffer-file-name))
    (backup-filename (concat (buffer-file-name) "[git]"))
    (pos (point))
     )  
  (message (concat "saving " backup-filename))
  (copy-file (buffer-file-name) (concat (buffer-file-name) "[git]"))
  )
)

(defun recover-for-git ()
  "recover-for-git"
  (interactive)
  (let (
    (filename (buffer-file-name))
    (backup-filename (concat (buffer-file-name) "[git]"))
    (pos (point))
     )  
  (message (concat "recovering " backup-filename))
  (copy-file (concat (buffer-file-name) "[git]") (buffer-file-name) t)
  (revert-buffer t t)
  (delete-file (concat (buffer-file-name) "[git]"))
  )
)
