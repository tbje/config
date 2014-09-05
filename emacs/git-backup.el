(defun file-name-git-recovery (file-name)
  "file name for git recovery file"
  (let ((name (file-name-sans-extension file-name))
        (ext (file-name-extension file-name)))
    (concat name "." ext "[git]")))

(defun file-name-git-recovery-old (file-name)
  "file name for git recovery file"
  (let ((name (file-name-sans-extension file-name))
        (ext (file-name-extension file-name)))
    (concat name "[git]." ext)))

;;(file-name-git-recovery "file-name.txt")

(defun backup-for-git ()
  "backup-for-git"
  (interactive)
  (let* ((file-name (buffer-file-name))
         (backup-file-name (file-name-git-recovery file-name))
         (pos (point)))
    (message "saving %s" backup-file-name)
    (copy-file (buffer-file-name) backup-file-name)))

(defun recover-for-git ()
  "recover-for-git"
  (interactive)
  (let* ((file-name (buffer-file-name))
        (backup-file-name-new (file-name-git-recovery file-name))
        (backup-file-name-old (file-name-git-recovery-old file-name))
        (backup-file-name (if (file-exists-p backup-file-name-new) backup-file-name-new backup-file-name-old))
        (pos (point)))
    (when (not (file-exists-p backup-file-name))
      (error "%s does not exist" backup-file-name))
    (message "recovering %s" backup-file-name)
    (copy-file backup-file-name file-name t)
    (revert-buffer t t)
    (delete-file backup-file-name)))

(defun diff-gitted ()
  "Diff current buffer against the git recovery file"
  (interactive)
  (let* ((gitted-file-name (file-name-git-recovery (buffer-file-name)))
         (config (current-window-configuration))
         (curr (current-buffer))
         (gitted-buff-name (generate-new-buffer-name gitted-file-name))
         (gitted-buff (get-buffer-create gitted-buff-name)))
    (when (not (file-exists-p gitted-file-name))
      (error "%s does not exist" gitted-file-name))
    (with-current-buffer gitted-buff
      (insert-file-contents gitted-file-name)
      (setq buffer-read-only t))
    (set-buffer
     (ediff-buffers curr gitted-buff))
    (add-hook 'ediff-quit-hook
              (lexical-let ((saved-config config))
                #'(lambda ()
                    (let ((buffer-B ediff-buffer-B))
                      (unwind-protect ; an error here is a real mess
                        (ediff-cleanup-mess)
                        (kill-buffer buffer-B)
                        (set-window-configuration saved-config)))))
              nil t)))
