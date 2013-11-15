;; find file at point, jump to line no.
;; ====================================

(require 'ffap)

(defun find-file-at-point-with-line-2()
  "if file has an attached line num goto that line, ie boom.rb:12"
  (interactive)
  (setq line-num 0)
  (save-excursion
    (search-forward-regexp "[^ ]:" (point-max) t)
    (if (looking-at "[0-9]+")
         (setq line-num (string-to-number (buffer-substring (match-beginning 0) (match-end 0))))))
  (find-file-at-point)
  (if (not (equal line-num 0))
      (goto-line line-num)))


(defun find-file-at-point-with-line (&optional filename)
  "Opens file at point and moves point to line specified next to file name."
  (interactive)
  (let* ((filename (or filename (ffap-prompter)))
     (line-number
      (and (or (looking-at ".* line \\(\[0-9\]+\\)")
           (looking-at ".*:\\(\[0-9\]+\\):"))
       (string-to-number (match-string-no-properties 1)))))
(message "%s --> %s" filename line-number)
(cond ((ffap-url-p filename)
       (let (current-prefix-arg)
     (funcall ffap-url-fetcher filename)))
      ((and line-number
        (file-exists-p filename))
       (progn (find-file-other-window filename)
          (goto-line line-number)))
      ((and ffap-pass-wildcards-to-dired
        ffap-dired-wildcards
        (string-match ffap-dired-wildcards filename))
       (funcall ffap-directory-finder filename))
      ((and ffap-dired-wildcards
        (string-match ffap-dired-wildcards filename)
        find-file-wildcards
        ;; Check if it's find-file that supports wildcards arg
        (memq ffap-file-finder '(find-file find-alternate-file)))
       (funcall ffap-file-finder (expand-file-name filename) t))
      ((or (not ffap-newfile-prompt)
       (file-exists-p filename)
       (y-or-n-p "File does not exist, create buffer? "))
       (funcall ffap-file-finder
        ;; expand-file-name fixes "~/~/.emacs" bug sent by CHUCKR.
        (expand-file-name filename)))
      ;; User does not want to find a non-existent file:
      ((signal 'file-error (list "Opening file buffer"
                 "no such file or directory"
                 filename))))))
