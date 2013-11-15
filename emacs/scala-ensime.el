;; Scala mode
(add-to-list 'load-path "~/scala-mode/")
(require 'scala-mode-auto)

;; ENSIME
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(add-to-list 'auto-mode-alist '("\\.console$" . scala-mode))
;(add-to-list 'load-path "~/ensime/dist_2.9.2/elisp/")
;(require 'ensime)

