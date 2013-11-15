(defun kill-this-buffer-volatile ()
    "Kill current buffer, even if it has been modified."
    (interactive)
    (if (get-buffer-process (current-buffer)) 
        (progn 
          (set-process-query-on-exit-flag (get-buffer-process (current-buffer)) nil)
          (kill-process (current-buffer))
        )
        nil
    )
    (set-buffer-modified-p nil)
    (kill-buffer (current-buffer))
)
