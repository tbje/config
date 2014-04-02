(defun set-utf-8-unix ()
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix)
  (save-buffer)
)

(defun read-as-dos ()
  (interactive)
  (revert-buffer-with-coding-system 'utf-8-dos t)
)

(defun swap-windows () "swap buffers of two windows"
  (interactive)
  (let ((this-windows-buffer (window-buffer))
        (other-windows-buffer (window-buffer (next-window (selected-window)))))
    (progn
      (set-window-buffer (next-window) this-windows-buffer)
      (set-window-buffer (selected-window) other-windows-buffer)
      )
))
