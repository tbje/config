(prefer-coding-system 'utf-8)
;;(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defun revert-to-utf-8 () 
    ""
    (interactive)
    (revert-buffer-with-coding-system 'utf-8-unix t)
)

;(global-set-key "\C-b\C-e" 'revert-to-utf-8)
