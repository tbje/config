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

;; (big-screen-mode)
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

(defun x-maximize-frame ()
    "Maximize the current frame (to full screen)"
    (interactive)
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (tooltip-mode -1)
    (set-frame-parameter nil 'fullscreen
              (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(defun x-minimize-frame () ""
(interactive)
    (tool-bar-mode 1)
    (menu-bar-mode 1)
    (tooltip-mode 1)
    (set-frame-parameter nil 'fullscreen nil)
;              (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
)

(defun toggle-fullscreen () "" 
(interactive) 
  (if (frame-parameter nil 'fullscreen) (x-minimize-frame) (x-maximize-frame))
)

;(toggle-fullscreen)
(x-maximize-frame)

(global-unset-key (kbd "s-f"))
(global-set-key (kbd "s-f") 'toggle-fullscreen)

(defun move-to-top-screen () ""
  (interactive)
  (x-minimize-frame)
  (modify-frame-parameters nil '((top . 10)))
  (x-maximize-frame)
)

(defun re-maximize ()
  (interactive)
  ;(ns-toggle-fullscreen)
  ;(set-default-font "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")  
  ;(ns-toggle-fullscreen)
)

(defun big-screen-mode ()
  "increase font size"
  (interactive)
  ;(set-default-font "-apple-Monaco-medium-normal-normal-*-18-*-*-*-m-0-iso10646-1")
)

;(big-screen-mode)
;(ns-toggle-fullscreen)

;(defun small-screen-mode ()
;  "increase font size"
;  (set-default-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
;)
