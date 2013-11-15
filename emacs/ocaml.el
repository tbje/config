;; -- Tuareg mode -----------------------------------------
;; Add Tuareg to your search path
(require 'tuareg)
(setq auto-mode-alist 
      (append '(("\.ml[ily]?$" . tuareg-mode))
	      auto-mode-alist))

;; -- Tweaks for OS X -------------------------------------
;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; init scripts when invoking a sub-shell
(cond
 ((eq window-system 'ns) ; macosx
  ;; Invoke login shells, so that .profile or .bash_profile is read
  (setq shell-command-switch "-lc")))

;; -- opam and utop setup --------------------------------
;; Setup environment variables using opam
(defun opam-vars ()
  (let* ((x (shell-command-to-string "opam config env"))
	 (x (split-string x "\n"))
	 (x (remove-if (lambda (x) (equal x "")) x))
	 (x (mapcar (lambda (x) (split-string x ";")) x))
	 (x (mapcar (lambda (x) (car x)) x))
	 (x (mapcar (lambda (x) (split-string x "=")) x))
	 )
    x))

;(opam-vars)
(dolist (var (opam-vars))
  (setenv (car var) (cadr var)))

;; The following simpler alternative works as of opam 1.1
;; (dolist
;;    (var (car (read-from-string
;; 	       (shell-command-to-string "opam config env --sexp"))))
;;  (setenv (car var) (cadr var)))

;; Update the emacs path
(setq exec-path (split-string (getenv "PATH") path-separator))
(getenv "OCAML_TOPLEVEL_PATH")
;; Update the emacs load path
(push (concat (getenv "OCAML_TOPLEVEL_PATH")
	      "/../../share/emacs/site-lisp") load-path)

;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
