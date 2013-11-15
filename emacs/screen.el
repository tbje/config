(defun re-maximize ()
  (interactive)
;;  (ns-toggle-fullscreen)
  (set-default-font "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")  
  ;; (ns-toggle-fullscreen)
)

(defun big-screen-mode ()
  "increase font size"
  (interactive)
  (set-default-font "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")
)

(big-screen-mode)
;; (ns-toggle-fullscreen)

(defun small-screen-mode ()
  "increase font size"
  (set-default-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
)

(defun screen-change ()
  "Create a new frame and delete others"
  (interactive)
  (new-frame)
  (delete-other-frames)
)
