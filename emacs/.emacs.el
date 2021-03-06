(defun load-config (file) 
  (load-file (expand-file-name (concat file ".el") "~/config/emacs"))
)

(load-config "init")
(load-config "secret")
(load-config "autosave") 
(load-config "db")
(load-config "buffer-util")
(load-config "case-util")
(load-config "git-emacs")
(load-config "facelift-macros")
(load-config "scala-macros")
(load-config "encoding")
(load-config "package-init")
(laod-config "jabber")
(load-config "tabbing")
(load-config "sbt-console")
(load-config "screen")
(load-config "git-backup")
(load-config "various")
(load-config "color-theme-init")
(load-config "keybindings")
;;(load-config "scala-ensime")
(load-config "multiple-cursors")
;;(load-config "clojure")
;;(load-config "ocaml")
