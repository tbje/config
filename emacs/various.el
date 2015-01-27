;(define-key sql-mode-map (quote [M-return]) 'sqlparser-mysql-complete)
;(define-key sql-interactive-mode-map  (quote [M-return]) 'sqlparser-mysql-complete)

(setq exec-path (append exec-path '("~/bin")))

(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:~/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path))

(add-hook 'html-mode (lambda () (local-unset-key '[160])))

(setq erc-server-history-list '("https://moxie.typesafe.com:6697"))

(add-hook 'before-save-hook 'delete-trailing-whitespace)


(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun save-no-hooks () "Do not remove trailing whitespaces when saving..."
  (interactive)
  (let ((before-save-hook (remove 'delete-trailing-whitespace before-save-hook))) (save-buffer)))

(setq redisplay-dont-pause t)
(set-default 'truncate-lines t)
(setq inhibit-startup-message t)

;;(desktop-save-mode 1)

(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(egg-enable-tooltip t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(defun ruthlessly-kill-line ()
  "Deletes a line, but does not put it in the kill-ring. (kinda)"
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (if (and (eq beg end) (< end (buffer-end 1)))
        (delete-region beg (+ 1 end))
        (delete-region beg end))
))


(defun auto-revert-open (f)
  (with-current-buffer (find-file f)
    (auto-revert-mode)
    (end-of-buffer)))


;;hist mode
;;(savehist-mode 1)


(defun git-logb ()
  (git-log-other (git--select-branch)))

(defun git-logob ()
  (git-log-other (git--select-remote "Select remote: ")))

(defcustom my-projects
  '()
  "A list with name and dir for projects."
  :type 'list
  :group 'personal)

(defcustom pr-urls
  '()
  "A list with dir name pull request url for each project.
   Example: '((\"~/zermex-site\" . \"https://github/git/Groosker/zermex-site\")"
  :type 'list
  :group 'personal)

(defun project ()
  (interactive)
  (helm :prompt "Project: " :sources '(
  ((name . "Jump to project")
    (candidates . my-projects)
    (action . (
               ("Jump" .       (lambda (dir) (cd dir)))
               ("Git status" . (lambda (dir) (git-status dir)))
               ("Git log" .    (lambda (dir) (git-log dir)))
               ))))))

(defun branches ()
  (interactive)
  (helm :prompt "Branch: " :sources `(
  ((name . "Jump to project")
    (candidates . ,(helm-branches default-directory))
    (action . (
               ("Return" .       (lambda (dir) (cd dir)))
               ("Git log" .    (lambda (b) (git-log-other b)))
               ))))))

(defun cons-same (a) `(,a . ,a))

(defun helm-branches (dir)
  (with-helm-default-directory dir
      (mapcar 'cons-same (car (git--branch-list)))))


(defun git-pr ()
  "Create a pull request against develop branch (master if not configured in pr-urls)"
  (let* ((top-dir (abbreviate-file-name (git--get-top-dir)))
         (github-data (cdr (assoc top-dir pr-urls)))
         (github-url (if (consp github-data) (car github-data) github-data))
         (github-merge (if (consp github-data) (cdr github-data) "master")))
    (concat github-url "/compare/" github-merge "..." (git--current-branch) "?expand=1")))

(defun git-log-dir (dir)
  (let ((default-directory dir))
    (git-log)))


(defun helm-scala-complete ()
  (interactive)
  (let* ((cand  (mapcar 'cons-same '("import scala.concurrent._"
                                     "import com.github.tbje.facelift.imports._"
                                     "implicit s: Session =>"
                                     "import scalaz._\nimport scalaz.Scalaz._"
                                     "import com.github.nscala_time.time.Imports._"
                                     "import concurrent.ExecutionContext.Implicits.global"
                                     "import com.efgfp.teleios.util._")))
         (sources   '((name . "Scala common")
                      (candidates . cand)
                      (action . (("paste" . (lambda (x) x)))))))
    (insert (helm :sources sources
          :prompt "Select scala completion:"
          :buffer "*helm-spotify*"))))
