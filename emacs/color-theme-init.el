(require 'color-theme)
;(color-theme-initialize)
;(color-theme-calm-forest)
;(color-theme-subtle-hacker)

;;(defun th-adwaita () "" (interactive) (load-theme 'adwaita t))
(defun th-brin () "" (interactive) (load-theme 'brin t))
;;(defun th-deeper-blue () "" (interactive) (load-theme 'deeper-blue t))
(defun th-dichromacy () "" (interactive) (load-theme 'dichromacy t))
(defun th-dorsey () "" (interactive) (load-theme 'dorsey t))
;;(defun th-flatui () "" (interactive) (load-theme 'flatui t))
(defun th-fogus () "" (interactive) (load-theme 'fogus t))
(defun th-graham () "" (interactive) (load-theme 'graham t))
(defun th-granger () "" (interactive) (load-theme 'granger t))
(defun th-hickey () "" (interactive) (load-theme 'hickey t))
(defun th-junio () "" (interactive) (load-theme 'junio t))
;;(defun th-light-blue () "" (interactive) (load-theme 'light-blue t))
;;(defun th-manoj-dark () "" (interactive) (load-theme 'manoj-dark t))
(defun th-mccarthy () "" (interactive) (load-theme 'mccarthy t))
;;(defun th-misterioso () "" (interactive) (load-theme 'misterioso t))
(defun th-odersky () "" (interactive) (load-theme 'odersky t))
(defun th-ritchie () "" (interactive) (load-theme 'ritchie t))
;;(defun th-spacegray () "" (interactive) (load-theme 'spacegray t))
(defun th-spolsky () "" (interactive) (load-theme 'spolsky t))
;;(defun th-tango () "" (interactive) (load-theme 'tango t))
;;(defun th-tango-dark () "" (interactive) (load-theme 'tango-dark t))
;;(defun th-tsdh-dark () "" (interactive) (load-theme 'tsdh-dark t))
;;(defun th-tsdh-light () "" (interactive) (load-theme 'tsdh-light t))
;;(defun th-wheatgrass () "" (interactive) (load-theme 'wheatgrass t))
;;(defun th-whiteboard () "" (interactive) (load-theme 'whiteboard t))
(defun th-wilson () "" (interactive) (load-theme 'wilson t))
;;(defun th-wombat () "" (interactive) (load-theme 'wombat t))
;;(defun th-dichromacy () "" (interactive) (load-theme 'dichromacy t))

(require 'doremi)

(defun doremi-themes ()
  "Successively cycle among color themes."
  (interactive)
  (let ((themes '(th-brin th-dorsey th-fogus th-graham th-granger th-hickey th-junio th-mccarthy th-odersky th-ritchie th-spolsky th-wilson)))
    (doremi (lambda (newval) (funcall newval) newval) ; call a theme command
            (car themes)                              ; start with last theme
            nil                                       ; ignored
            nil                                       ; ignored
            themes)))

(th-fogus)
