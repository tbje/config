;;(define-key sql-mode-map (quote [M-return]) 'sqlparser-mysql-complete)
                                        ;(define-key sql-interactive-mode-map  (quote [M-return]) 'sqlparser-mysql-complete)

(prefer-coding-system 'utf-8)

(defun cleanse-subject (subject) ""
       "ok")



;;(defun ediff-buffer-with-file (&optional buffer)
;;  "View the differences between BUFFER and its associated file.
;;This requires the external program `diff' to be in your `exec-path'."
;;  (interactive "bBuffer: ")
;;  (with-current-buffer (get-buffer (or buffer (current-buffer)))
;;    (ediff buffer-file-name (current-buffer) nil)))



(defadvice find-file (around find-files activate)
  "Also find all files within a list of files. This even works recursively."
  (if (listp filename)
      (loop for f in filename do (find-file f wildcards))
    ad-do-it))

(defun browse-url-vivaldi (url &optional _new-window)
  "Ask the Chromium WWW browser to load URL.
Default to the URL around or before point.  The strings in
variable `browse-url-chromium-arguments' are also passed to
Chromium."
  (interactive (browse-url-interactive-arg "URL: "))
  (setq url (browse-url-encode-url url))
  (let* ((process-environment (browse-url-process-environment)))
    (apply 'start-process
	   (concat "vivaldi " url) nil
	   "vivaldi"
	   (append
	    browse-url-chromium-arguments
	    (list url)))))



  (defun shk-yas/helm-prompt (prompt choices &optional display-fn)
    "Use helm to select a snippet. Put this into `yas-prompt-functions.'"
    (interactive)
    (setq display-fn (or display-fn 'identity))
    (if (require 'helm-config)
        (let (tmpsource cands result rmap)
          (setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
          (setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
          (setq tmpsource
                (list
                 (cons 'name prompt)
                 (cons 'candidates cands)
                 '(action . (("Expand" . (lambda (selection) selection))))
                 ))
          (setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
          (if (null result)
              (signal 'quit "user quit!")
            (cdr (assoc result rmap))))
      nil))


;;
;;  (unless helm-source-buffers-list
;;    (setq helm-source-buffers-list
;;          ;; Todo sort the action and candiates
;;          (helm-make-source "Buffers" 'helm-source-buffers)))
;;  (helm :sources '(helm-source-buffers-list
;;                   helm-source-ido-virtual-buffers
;;                   helm-source-buffer-not-found)
;;        :buffer "*helm buffers*")
;;  ;; Todo call mml-attach-file with result from file.
;;  (message "ok")
;;  )


(defun digit-string-month (str)
  (pcase str
    ("01" "jan")
    ("02" "feb")
    ("03" "mar")
    ("04" "apr")
    ("05" "may")
    ("06" "jun")
    ("07" "jul")
    ("08" "aug")
    ("09" "sep")
    ("10" "oct")
    ("11" "nov")
    ("12" "dec")
    (sel sel)))

(defun replace-digit-with-month (beg end)
  "message region or \"empty string\" if none highlighted"
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (let* ((sel (buffer-substring-no-properties beg end))
         (res (digit-string-month sel)))
  (if (and beg end)
        (progn
          (goto-char beg)
          (delete-region beg end)
          (insert res)
          res))))



(defun today-scala ()
  (interactive)
    (insert (today-scala-string)))

 (defun timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%dT%H:%M:%S")))


(defun get-month () (nth 4 (decode-time (current-time))))
(defun get-year () (nth 5 (decode-time (current-time))))
(defun get-day () (nth 3 (decode-time (current-time))))

(require 'seq)
(defun today-scala-string ()
  (format "%2d %s %d" (get-day)
              (nth (- (get-month) 1) '("jan" "feb" "mar" "apr" "may" "jun" "jul" "aug" "sep" "oct" "nov" "dec"))
              (get-year)))

(defun today-scala-string-curr ()  (interactive)
  (insert (concat "Ex(" (today-scala-string) ",      0.00 chf, \"\") ++")))

(eval-after-load "term"
  '(progn
     (define-key term-raw-map (kbd "C-<left>") 'send-ctrl-left)
     (define-key term-raw-map (kbd "C-<right>") 'send-ctrl-right)
     (define-key term-raw-map (kbd "<backspace>") 'term-send-backspace)))

(defun send-ctrl-left ()
  (interactive)
  (term-send-raw-string "\e[1;5D"))

(defun send-ctrl-right ()
  (interactive)
  (term-send-raw-string "\e[1;5C"))

(defun training ()
  (interactive)
  (forms-find-file "~/training.form"))

(defun todo ()
  (interactive)
  (find-file "~/todo.org"))

(require 'nexus)

 (defun clipboard-yank-2 ()
  "Insert the primary selection at the position clicked on.
Move point to the end of the inserted text, and set mark at
beginning.  If `mouse-yank-at-point' is non-nil, insert at point
regardless of where you click."
  (interactive)
  ;; Give temporary modes such as isearch a chance to turn off.
  ;; Without this, confusing things happen upon e.g. inserting into
  ;; the middle of an active region.
  (let ((primary
         (if (fboundp 'x-get-selection-value)
             (if (eq (framep (selected-frame)) 'w32)
                 ;; MS-Windows emulates PRIMARY in x-get-selection, but not
                 ;; in x-get-selection-value (the latter only accesses the
                 ;; clipboard).  So try PRIMARY first, in case they selected
                 ;; something with the mouse in the current Emacs session.
                 (or (x-get-selection 'PRIMARY)
                     (x-get-selection-value))
               ;; Else MS-DOS or X.
               ;; On X, x-get-selection-value supports more formats and
               ;; encodings, so use it in preference to x-get-selection.
               (or (x-get-selection-value)
                   (x-get-selection 'PRIMARY)))
           ;; FIXME: What about xterm-mouse-mode etc.?
           (x-get-selection 'PRIMARY))))
    (unless primary
      (error "No selection is available"))
    (push-mark (point))
    (insert-for-yank primary)))


(setq exec-path (append exec-path '("~/bin")))

(defun delete-file-current-buffer ()
  ""
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name))
    (message "Deleting %s" (buffer-file-name))
    (delete-file filename)
    (kill-buffer)))

;  (doc-view-kill-proc-and-buffer))



(defun file-name () "Insert at point fileName without ext"
       (interactive)
       (insert (file-name-base buffer-file-name)))

(defun sbt-run ()
  (interactive)
  (sbt-command "run" t))

(defun sbt-restart ()
  (interactive)
  (sbt-command "restart"))

(defun sbt-reStart ()
  (interactive)
  (sbt-command "reStart"))

(defun sbt-fastOptS ()
  (interactive)
  (sbt-command "sharedJS/fastOptJS"))

(defun sbt-fastOpt ()
  (interactive)
  (sbt-command "fastOptJS"))

(defun sbt-ensimeConf ()
  (interactive)
  (sbt-command "ensimeConfig"))

(defun gen-pass ()
  "generate a new password"
  (interactive)
  (kill-new (trim-string (shell-command-to-string "/home/tbje/bin/gen"))))


(require 'dash)
(defun strip-package (dir)
  (let* ((elems (split-string dir  "/" ))
         (after-scala (-drop-while (lambda (x) (not (string-equal x "scala"))) elems))
         (with-file (-drop 1 after-scala))
         (pck (-drop-last 1 with-file)))
    (if (not pck) ""
      (-reduce (lambda (x y) (concat x "." y)) pck))))

;; (strip-package "test/ok/scala/Test.scala")
;; (strip-package "test/ok/scala/test/ok/crazy/Test.Scala")
;; (strip-package "test/ok/scala/yeah/ok")

(defun package-insert ()
  "insert the package accoring to file structure"
  (interactive)
  (let*
      ((dir (buffer-file-name))
       (pck (strip-package dir)))
    (insert (format "package %s" pck))))

(defun jump-to-test ()
  ""
  (interactive)
  (let*
      ((dir (buffer-file-name))
       (test-dir (replace-regexp-in-string "src/main/scala" "src/test/scala" dir))
       (class (file-name-base dir))
       (test-class (replace-regexp-in-string (concat class ".scala") (concat class "Spec.scala") test-dir)))
  (find-file test-class)))

(defun jump-to-class ()
  ""
  (interactive)
  (let*
      ((dir (buffer-file-name))
       (test-dir (replace-regexp-in-string "src/test/scala" "src/main/scala"  dir))
       (test-class (file-name-base dir))
       (class (replace-regexp-in-string "Spec" "" test-class))
       (final (replace-regexp-in-string (concat test-class ".scala") (concat class ".scala") test-dir)))
    (message "%s %s %s" class final test-class)
  (find-file final)))

(defun test-imp ()
  ""
  (interactive)
  (let* ((dir (buffer-file-name))
         (test-dir (replace-regexp-in-string "src/main/scala" "src/test/scala" dir))
         (class (file-name-base dir))
         (test-class (replace-regexp-in-string (concat class ".scala") (concat class "Spec.scala") test-dir))
         (pck (strip-package dir)))
    (find-file test-class)
    (insert (concat "package " (strip-package dir)))
    (newline nil t)
    (newline nil t)
    (insert "import org.scalatest.{ Matchers, WordSpec }")
    (newline nil t)
    (newline nil t)
    (insert (concat "class " class "Spec extends WordSpec with Matchers{"))
    (newline nil nil)
    (indent-according-to-mode)
    (insert "\"Using" class "\" should {")
    (newline nil nil)
    (indent-according-to-mode)
    (insert "\"do the following\" in {")
    (newline nil nil)
    (indent-according-to-mode)
    (insert "\"test\" shouldEqual null")
    (newline nil nil)
    (insert "}")
    (indent-according-to-mode)
    (newline nil nil)
    (insert "}")
    (indent-according-to-mode)
    (newline nil nil)
    (insert "}")))

(defun class ()
  "Creates a new class in the current dir"
  (interactive)
  (class-cr "class")
)

(defun import-comp ()
  "Creates a new class in the current dir"
  (interactive)
  (let ((class (file-name-base (buffer-file-name))))
    (insert (concat "import " class "._"))))


(defun compagnion ()
  "Creates a compagnian object"
  (interactive)
  (let ((class (file-name-base (buffer-file-name))))
    (insert (concat "object " class " {"))

    (newline nil nil)
    (newline nil nil)
    (insert "}")
    (forward-line -1)
    (indent-according-to-mode)
    ))


(defun object ()
  "Creates a new object in the current dir"
  (interactive)
  (class-cr "object")
)

(defun trait ()
  "Creates a new trait in the current dir"
  (interactive)
  (class-cr "trait")
)

(defun find-where-to-create ()
  (interactive)
  (let* ((file (buffer-file-name))
         (dir (file-name-directory file)))
    (or sbt:buffer-project-root (sbt:find-root))
  (message "%s" (string= dir (expand-file-name sbt:buffer-project-root)))))


(defun class-cr (name)
  "Creates a new class in the current dir"
  (let* ((class (read-from-minibuffer (concat (capitalize name) " name: ")))
        (dir (buffer-file-name))
        (pck (strip-package dir)))
    (find-file (concat "./" class ".scala"))
    (if (not (= (length pck) 0))
        (progn
          (insert (concat "package " pck))
          (newline nil t)))
    (newline nil t)
    (insert (concat name " " class " {"))
    (newline nil nil)
    (insert "}")))


(defun chose-dir (input)
  "Return ' -d' or ' -b' if 'd' or 'b' and '' when f"
  (pcase input
    ((or "p" "personal") "/home/tbje/scans/")
    ((or "g" "groosker") "/home/tbje/groosker-files/")))


(defun duplex-cmd-line (input)
  "Return ' -d' or ' -b' if 'd' or 'b' and '' when f"
  (pcase input
    ((or "d" "duplex") " -d")
    ((or "i" "interactive") " -i")
    ((or "b" "back") " -b")
    ((or "f" "front") "")))


(defun extract-date-cal ()
  (let* ((paid (parse-time-string (org-read-date)))
         (y (nth 5 paid))
         (m (nth 4 paid))
         (d (nth 3 paid)))
    (format "%d%02d%02d" y m d)))

(defun extract-date-today-defaults ()
  (extract-date (string-to-number (format-time-string "%d"))
         (string-to-number (format-time-string "%m"))
         (string-to-number (format-time-string "%Y"))))


(defun extract-date (default-day default-month default-year)
  (let* ((day (read-number "day: " default-day))
         (month (read-number "month: " default-month))
         (year (read-number "year: " default-year)))
  (format "%02d.%02d.%d" day month year)))


(defun tagger-upd (cmd)
  (let* ((tagger "/home/tbje/tagger/target/scala-2.11/tagger-out")
         (filename (buffer-file-name)))
    (tagger cmd)
    (view-tags)))

(defun tagger (cmd)
  (let* ((tagger "/home/tbje/tagger/target/scala-2.11/tagger-out")
         (filename (buffer-file-name)))
    (shell-command (format "%s %s %s" tagger cmd filename))))

(defun tagger-adv (func)
  (let* ((tagger "/home/tbje/tagger/target/scala-2.11/tagger-out")
         (filename (buffer-file-name)))
    (progn
      (tagger-upd (funcall func (shell-command-to-string (format "%s %s %s" tagger "" filename)))))))

(defun string-fix (x)
  (let ((split (s-split " " x)))
  (amount-tagger-string (ask-amount-defaults (nth 1 split) (s-chop-suffix "," (nth 2 split))))))



(defun update-amount ()
  (interactive)
  (tagger-adv 'string-fix))

(defun ask-amount-defaults (amount curr)
  (let ((am (read-from-minibuffer "Amount: " amount)))
    (if (s-blank? am) ""
      (concat am " " (completing-read "Currency: " currencies nil t curr)))))

(defcustom currencies
  '(("CHF" 1) ("USD" 1) ("NOK" 1) ("GBP" 1) ("EUR" 1) ("DKK" 1))
  "A list of companies for completion in rename-company."
  :type 'list
  :group 'personal)

(defun tag-amount ()
  (interactive)
  (let* ((amount (read-from-minibuffer "Amount: "))
         (curr (completing-read "Currency [CHF]: " currencies nil t "CHF")))
    (tagger-upd (format "--amount %s --curr %s" amount curr))))


(defun tag-person ()
  (interactive)
  (tagger-upd (format "--person %s" (completing-read "Who: "
                                   '(("Clothilde" 1) ("Myrtille" 1) ("Trond" 1)) nil nil "Trond"))))

(defun tag-desc ()
  (interactive)
  (tagger-upd (format "--desc %s" (completing-read "What: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-descriptions) nil nil ""))))

(defun tag-company ()
  (interactive)
  (tagger-upd (format "--company %s" (completing-read "Company: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-companies) nil nil ""))))

(defun tag-from-file-name ()
  (interactive)
  (let* ((name (file-name-nondirectory (buffer-file-name)))
         (splitted (s-split "-" (s-chop-suffix ".pdf" name)))
         (date (nth 0 splitted))
         (month (s-left 2 date))
         (day (s-right 2 date))
         (company (nth 1 splitted))
         (what (nth 2 splitted))
         (year (read-number "year: " (string-to-number (format-time-string "%Y")))))
  (tagger-upd (format "--date %s.%s.%s --company %s --desc %s" day month year company what))))

(defun tag-due ()
  (interactive)
  (tagger-upd (format "--due %s" (extract-date-today-defaults))))

(defun tag-date ()
  (interactive)
  (tagger-upd (format "--date %s" (extract-date-today-defaults))))

(defun tag-paid ()
  (interactive)
  (tagger-upd (format "--paid %s" (extract-date-today-defaults))))

(defun tag-paid-cal ()
  (interactive)
  (tagger-upd (format "--paid %s" (extract-date-cal))))

(defun filename-from-tag ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name))
        (tagger "/home/tbje/tagger/target/scala-2.11/tagger-out"))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (s-trim (shell-command-to-string (format "%s %s %s" tagger "--filenameQ" filename)))))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))



(defun view-tags ()
  (interactive)
  (tagger ""))


(defun eshell-here ()
  (interactive)
  (elisp-cmd-here ""))

(defun ansi-here (cmd buffer-prefix)
  (let* ((parent (file-name-directory (or (buffer-file-name)
                                      default-directory)))
         (name   (car
                  (last
                   (split-string parent "/" t))))
         (b-name (concat "*" buffer-prefix ": " name "*")))
    (or (string-equal (buffer-name) b-name)
        (progn
          (split-window-vertically)
          (other-window 1)))
  (switch-to-buffer (term-ansi-make-term b-name "/bin/bash" nil "-c" cmd))))

(defun tree-here ()
  (interactive)
    (ansi-here "tree -I \"target|*~|*#\"" "tree"))

(defun tree-dir-here ()
  (interactive)
    (ansi-here "tree -d -I \"target|*~|*#\"" "tree-dir" ))

(defun elisp-cmd-here (cmd)
  "Opens up a new shell in the directory associated with the current buffer's file."
  (let* ((parent (file-name-directory (or (buffer-file-name)
                                      default-directory)))
         (name   (car
                  (last
                   (split-string parent "/" t))))
         (eshell-name (concat "*eshell: " name "*")))
    (or (string-equal (buffer-name) eshell-name)
        (progn
          (split-window-vertically)
          (other-window 1)))
    (if (get-buffer eshell-name)
        (switch-to-buffer eshell-name)
      (progn
        (eshell "new")
        (rename-buffer eshell-name)))
        (insert cmd)
        (eshell-send-input)))

(defun tagger-here ()
  (interactive)
  (elisp-cmd-here "tagger2"))

(defun ll-here ()
  (interactive)
  (ansi-here "ls -alF" "ll"))

(defun ocr ()
  (interactive)
  (let ((res (shell-command-to-string "~/emacs-ocr/target/scala-2.11/emacs-ocr-out")))
    (message "%s" res)
    (kill-new res)))

(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(defun pdf-view-add-keys ()
  (define-key pdf-view-mode-map (kbd "v") 'view-tags))
(add-hook 'pdf-view-mode-hook 'pdf-view-add-keys)



(defun exp-code-here ()
  (interactive)
  (elisp-cmd-here "tagger2 --fp"))

(defun run-in-eshell (command)
  (interactive)
  (with-current-buffer "*eshell*"
    (eshell-return-to-prompt)
    (insert command)
    (eshell-send-input)
    (kill-line)
    (sleep-for 1)
    (eshell-return-to-prompt)
    (kill-line)
    (View-scroll-to-buffer-end)
    ;(eshell-return-to-prompt)
    ))

(defun run-tagger ()
  (interactive)
  (run-in-eshell "tagger"))

(defun paid ()
  (interactive)
  (let* ((name (buffer-name))
         (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (shell-command (format "tagger --file %s" filename)))))

(defun scanned ()
  ""
  (interactive)
  (dired "~/scans"))

(defcustom letter-companies
  '("helsana" "zurich" "ubs" "allianz" "sunrise" "swisscom" "postfinance" "axa" "generali")
  "A list of companies for completion in rename-company."
  :type 'list
  :group 'personal)

(defcustom letter-descriptions
  '("breakfast" "lunch" "dinner" "train"
    "airbnb" "metro" "flight" "hotel" "tax"
    "facture" "letter" "releve-de-compte" "decompte" "avis" "contrat")
  "A list of descriptions for completion in scan."
  :type 'list
  :group 'personal)


;(defun scan ()
;  "The new and awsomer way to scan stuff "
;  (let* ((cur_month (
;         (month (completing-read "Month []: "))
;         (company (completing-read "Company: "
;                                       (mapcar (lambda (a) `(,a . 1)) letter-companies) nil nil))
;             (what (completing-read "What: "
;                                    '(("facture" 1) ("letter" 4) ("releve-de-compte" 1) ("avis" 1) ("contrat" 3) nil nil))))))))


(defun rename-letter ()
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (let* ((date (read-from-minibuffer "Date [MMDD]: "))
             (company (completing-read "Company: "
                                       (mapcar (lambda (a) `(,a . 1)) letter-companies) nil nil))
             (what (completing-read "What: "
                                    '(("facture" 1) ("letter" 4) ("releve-de-compte" 1) ("avis" 1) ("contrat" 3) nil nil)))
             (new-name-prefix (concat date "-" company "-" what))
             (new-name (concat (get-name-receipt new-name-prefix "pdf"))))
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun amount-tagger-string (str)
  "separate amount and currency"
  (let ((splitted (s-split " " str)))
  (concat " --amount " (nth 0 splitted) " --curr " (nth 1 splitted) " ")))

(defun rename-receipt ()
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (let* (
             (current-day (string-to-number (format-time-string "%d")))
             (current-month (string-to-number (format-time-string "%m")))
             (current-year (string-to-number (format-time-string "%Y")))
             (day (read-number "day: " current-day))
             (month (read-number "month: " current-month))
             (year (read-number "year: " current-year))
             (company (completing-read "Company: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-companies) nil nil ""))
             (what (completing-read "What: "
                                    (mapcar (lambda (a) `(,a . 1)) letter-descriptions) nil nil ""))
             (amount (ask-amount))
             (amount-tagger (if (s-blank? amount) "" (amount-tagger-string amount)))
             (name-prefix (format "%02d%02d-%s-%s" month day company what))
             (new-name (concat (get-name-receipt name-prefix "pdf"))))
        (progn
          (tagger-upd (format "%s--desc %s --date %02d.%02d.%02d --company %s" amount-tagger what day month year company))
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun ask-amount ()
  (let ((am (read-from-minibuffer "Amount: ")))
    (if (s-blank? am) ""
      (concat am " " (completing-read "Currency [CHF]: " currencies nil t "CHF")))))

; (fmakunbound 'add-amount)
(defun get-name-receipt (name ext)
  (let ((new-name (concat name "." ext)))
    (if (or (get-buffer new-name) (file-exists-p new-name))
       (get-suffix-receipt name 2 ext) new-name)))

;(get-name-receipt "0121-criteo-highway-toll" "pdf")

(defun get-suffix-receipt (name id ext)
  (let ((try-name (format "%s-%d.%s" name id ext)))
    (if (or (get-buffer try-name) (file-exists-p try-name))
        (get-suffix-receipt name (+ 1 id) ext) try-name)))


(defun move-current-buffer-file-to (to)
  "Renames current buffer and file it is visiting."
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (concat to "/" name)))
        (rename-file filename new-name)
        (rename-buffer new-name)
        (set-visited-file-name new-name)
        (set-buffer-modified-p nil)
        (message "File '%s' successfully moved to '%s'"
                 name new-name)))))

(pdf-tools-install)

(defun groosker-invoice ()
  (interactive)
  (move-current-buffer-file-to "~/groosker-files/Invoices"))


(defun groosker-receipt ()
  (interactive)
  (require 'cl-lib)
  (let* ((dir-name "~/groosker-files/Receipts/2017")
         (files (directory-files-and-attributes dir-name))
         (dirs (cl-remove-if-not (lambda (x) (cadr x)) files))
         (dir-comp (mapcar (lambda (x) `(,(car x) . 1)) (nthcdr 2 dirs)))
         (folder-try (completing-read "Folder (n = new): " dir-comp nil nil))
         (folder (if (equal folder-try "n")
                     (let ((f (read-from-minibuffer "New folder: ")))
                       (message "Creating dir %s" (concat dir-name "/" f))
                       (make-directory  (concat dir-name "/" f))
                       f)
                   folder-try)))
    (move-current-buffer-file-to (concat dir-name "/" folder))))


(defun move-scans ()
  (interactive)
  (move-current-buffer-file-to "~/scans/"))

(defun groosker-signin ()
  (interactive)
  (move-current-buffer-file-to "~/groosker-files/Sign-in"))

(defun groosker-avis ()
  (interactive)
  (move-current-buffer-file-to "~/groosker-files/ubs-avis"))

(defun groosker-bill ()
  (interactive)
  (move-current-buffer-file-to "~/groosker-files/Bills"))

(defun g2015 ()
  (interactive)
  (move-current-buffer-file-to "./2015"))

(defun g2016 ()
  (interactive)
  (move-current-buffer-file-to "./2016"))

(defun g2017 ()
  (interactive)
  (move-current-buffer-file-to "./2017"))

(defun hunger ()
  (interactive)
  (move-current-buffer-file-to "(/home/tbje/fidulem"))

(defun groosker ()
  (interactive)
  (move-current-buffer-file-to "~/groosker-files"))

(defun current-buffer-file-name ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((name (buffer-name))
        (full-path (buffer-file-name))
        (file-name (file-name-nondirectory full-path)))
    (message (concat "\"" file-name "\" added to kill-ring"))
  (kill-new file-name)))

(defun other-window-file-name ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((buffer (window-buffer (next-window (selected-window))))
         (full-path (buffer-file-name buffer))
         (file-name (file-name-nondirectory full-path)))
    (message "%s" (concat "\"" file-name "\" added to kill-ring"))
  (kill-new file-name)))

(defun current-buffer-full-path ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (file-path (buffer-file-name)))
    (message (concat "\"" file-path "\" added to kill-ring"))
    (kill-new file-path)))

(defun expense-line-from-file-name (file-name)
  (let* (
         (elems (s-match "^\\([0-9]\\{2\\}\\)\\([0-9]\\{2\\}\\)-\\(.*\\)-\\(.*\\)\\..*$" file-name))
         (day (string-to-number (nth 2 elems)))
         (month (nth 1 elems))
         (company (nth 3 elems))
         (what (s-capitalize (nth 4 elems))))
    (format "      Ex(%2d %s 2017,         0 chf, \"%s\", \"%s\") ++\n" day (digit-string-month month) what file-name)))

(defun insert-line-from-file-other-window ()
  (interactive)
  (let* ((buffer (window-buffer (next-window (selected-window))))
         (file-name (file-name-nondirectory (buffer-file-name buffer))))
    (insert (expense-line-from-file-name file-name))))


(defun find-same-file-other-buffer ()
                             (interactive)
                             (split-window)
                             (select-window (next-window))
                             (phi-search))

(defun create-line-from-clipboard ()
  (interactive)
    (insert (expense-line-from-file-name (substring-no-properties (current-kill 0)))))


(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun copy-current-buffer-file ()
  "Copies file in current buffer is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (copy-file filename new-name)
          (message "File '%s' successfully copied to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defun delete-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((abort (read-minibuffer (concat "Delete " filename " (n to abort): "))))
        (if (not (equal abort "n"))
            (progn
              (delete-file filename)
              (kill-buffer name)
              (message "File '%s' successfully deleted." filename)))))))


(defun chmod-current ()
  "Making buffer file u+x."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((mode (read-file-modes-mod (concat "Chmod " filename ": ") filename)))
        (chmod filename mode)
        (message "File '%s' successfully chmoded to %d." filename mode)))))

(defun read-file-modes-mod (&optional prompt orig-file)
  "Read file modes in octal or symbolic notation and return its numeric value.
PROMPT is used as the prompt, default to `File modes (octal or symbolic): '.
ORIG-FILE is the name of a file on whose mode bits to base returned
permissions if what user types requests to add, remove, or set permissions
based on existing mode bits, as in \"og+rX-w\"."
  (let* ((modes (or (if orig-file (file-modes orig-file) 0)
		    (error "File not found")))
	 (modestr (and (stringp orig-file)
		       (nth 8 (file-attributes orig-file))))
	 (default
	   (and (stringp modestr)
		(string-match "^.\\(...\\)\\(...\\)\\(...\\)$" modestr)
		(replace-regexp-in-string
		 "-" ""
		 (format "u=%s,g=%s,o=%s"
			 (match-string 1 modestr)
			 (match-string 2 modestr)
			 (match-string 3 modestr)))))
	 (value (read-string (or prompt "File modes (octal or symbolic): ")
			     "u+x" nil default)))
    (save-match-data
      (if (string-match "^[0-7]+" value)
	  (string-to-number value 8)
	(file-modes-symbolic-to-number value modes)))))


;(chmod "/home/tbje/bin/startNet.sh" (file-modes-symbolic-to-number "u+x"))
;(read-from-minibuffer (concat "Chmod " ": ") "u+x")

(defun move-current-buffer-file ()
  "Moves current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-directory-name "Move to: " )))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))


(when (equal system-type 'darwin)
  (setenv "PATH" (concat "/opt/local/bin:/usr/local/bin:~/bin:" (getenv "PATH")))
  (push "/usr/local/bin" exec-path))

(add-hook 'html-mode (lambda () (local-unset-key '[160])))

(add-hook 'markdown-mode 'display-all)

(defun accounting ()
  (interactive)
  (find-file "~/tbjesoft/src/main/scala/tbje/model/expenses/Year2017.scala")
  (ensime))

(defun ac-start ()
  (interactive)
  (find-file "~/tbjesoft/src/main/scala/tbje/model/expenses/Year2017.scala")
  (ensime))

(defun ac-refund ()
  (interactive)
  (find-file "/home/tbje/tbjesoft/src/main/scala/tbje/model/expenses/Expense.scala"))

(defun ac-refund-run ()
  (interactive)
  (sbt-command "runMain tbje.model.expenses.Expense"))

(defun ac-invoice-run ()
  (interactive)
  (sbt-command "runMain tbje.model.InvoiceGen"))

(defun ac-invoice ()
  (interactive)
  (find-file "/home/tbje/tbjesoft/src/main/scala/tbje/model/Invoice.scala"))

(defun scala-train ()
  (interactive)
  (let ((dir "~/scalatrain/src/main/scala/")
        (package "com/typesafe/training/scalatrain/")
        (file "Train.scala"))
    (if (file-exists-p (concat dir package file))
        (find-file (concat dir package file))
      (find-file (concat dir "Train.scala"))))
  (ensime))


(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(defun eshell-emit-prompt ()
  "Emit a prompt if eshell is being used interactively."
  (run-hooks 'eshell-before-prompt-hook)
  (if (not eshell-prompt-function)
      (set-marker eshell-last-output-end (point))
    (let* ((prompt (funcall eshell-prompt-function))
           (len (length prompt)))
      (and eshell-highlight-prompt
          (add-text-properties 0 (1- len)
                               '(read-only t
                                 face eshell-prompt)
                               prompt)
           (add-text-properties (1- len) len
				'(read-only t
				  face eshell-prompt
				  rear-nonsticky (face read-only))
				prompt))
      (eshell-interactive-print prompt)))
  (run-hooks 'eshell-after-prompt-hook))

(defun save-bookmark-before-kill ()
  (interactive)
  (progn
    (save-bmk-bmenu-state-file)
    (save-buffers-kill-terminal)))


(defun save-bmk-bmenu-state-file ()
  (if (get-buffer ".emacs-bmk-bmenu-state.el")
      (progn
        (message "exists")
        (with-current-buffer ".emacs-bmk-bmenu-state.el"
          (save-buffer)))))

(save-bmk-bmenu-state-file)

(add-hook 'kill-emacs-hook 'save-bmk-bmenu-state-file)

(setq erc-server-history-list '("https://moxie.typesafe.com:6697"))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun adt ()
  (interactive)
  (let  ((name (read-from-minibuffer "ADT name: "))
         (imp (read-number "implementations: ")))
  (insert (concat "sealed trait " name ))
  (dotimes (a imp t)
    (insert (concat "case class extends " name)))
  (indent-according-to-mode)))


(defun search-selection ()
  "search for selected text or default to isearch-forward"
  (interactive)
  (if (use-region-p)
      (let* ((beg (min (point) (mark)))
             (end (max (point) (mark)))
             (selection (buffer-substring-no-properties beg end))
         )
      (deactivate-mark)
      (isearch-mode t nil nil nil)
      (isearch-yank-string selection)
    )
    (isearch-forward)
   )
)

(defun open-selected-file ()
  "search for selected text or default to isearch-forward"
  (interactive)
  (if (use-region-p)
      (let* ((beg (min (point) (mark)))
             (end (max (point) (mark)))
             (dir (buffer-file-name))
             (selection (buffer-substring-no-properties beg end)))
      (deactivate-mark)
      (isearch-mode t nil nil nil)
      (if (s-contains-p "Year2016.scala" dir)
          (find-file (concat "/home/tbje/groosker-files/Bills/2016/" selection))
          (find-file selection))
    )
    (isearch-forward)
   )
)

(defun open-selected-file ()
  "search for selected text or default to isearch-forward"
  (interactive)
  (if (use-region-p)
      (let* ((beg (min (point) (mark)))
             (end (max (point) (mark)))
             (dir (buffer-file-name))
             (selection (buffer-substring-no-properties beg end)))
      (deactivate-mark)
      (find-file selection))))

(defun untabify-buffer ()
  (interactive )
  (untabify (point-min) (point-max)))


(defun search-selection (beg end)
  "search for selected text"
  (interactive "r")
  (let (
        (selection (buffer-substring-no-properties beg end))
        )
    (deactivate-mark)
    (isearch-mode t nil nil nil)
    (isearch-yank-string selection)
    )
  )

(fset 'move-curly-up
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([67108896 19 123 left 23 backspace backspace 31 32 5 right] 0 "%d")) arg)))

(defun untabify-buffer ()
  (interactive )
  (untabify (point-min) (point-max)))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

<<<<<<< HEAD
(defun display-all () ""
  (interactive)
  (progn
    (setq truncate-lines nil)
    (setq word-wrap t)))


(defun doc-view-next () "Move one file forward"
       (interactive)
       (find-file (doc-view-next-func (buffer-file-name) )))

(defun doc-view-next-func (full-file-name) "" ;  &optional list-func
       (let*
           ((file-name (file-name-nondirectory full-file-name))
            ;(lst-func (if list-func list-func (lambda (x) x)))
            (dir-name (file-name-directory (directory-file-name full-file-name)))
            (files (cdr (cdr (directory-files dir-name))))
            (after (drop-while (lambda (name) (not (equal name file-name))) files)))
         (if (equal nil (cdr after)) (error "No more files")
           (concat dir-name (cadr after)))))

(defun doc-view-next-func-2 (full-file-name lst-func) "" ;  &optional list-func
       (let*
           ((file-name (file-name-nondirectory full-file-name))
            (dir-name (file-name-directory (directory-file-name full-file-name)))
            (files (funcall lst-func `(,(directory-files dir-name))))
            (after (drop-while (lambda (name) (not (equal name file-name))) files)))
         (if (equal nil (cdr after)) (error "No more files")
           (concat dir-name (cadr after)))))


(defun list-major ()
  (interactive)
  (message "%s" major-mode))

;(doc-view-next-func "/home/tbje/scan/1116-kubi-raspberry.pdf")
;(doc-view-next-func-2 "/home/tbje/scanned/1209-dinner.pdf" 'nreverse)
;(doc-view-next-func-2 "/home/tbje/scanned/1209-dinner.pdf" (lambda (x) x))

(defun doc-view-prev () "Move one file backwards"
       (interactive)
       (let*
           ((full-file-name (buffer-file-name))
            (file-name (file-name-nondirectory full-file-name))
            (dir-name (file-name-directory (directory-file-name full-file-name)))
            (files (nreverse (cdr (cdr (directory-files dir-name)))))
            (after (drop-while (lambda (name) (not (equal name file-name))) files)))
         (if (equal nil (cdr after)) (message "No more files")
           (find-file (concat dir-name "/" (cadr after))))))


;(nreverse '(a b c d))

(defun drop-while (pred lst) ""
       (progn
         (if (eq lst nil) nil
           (if (funcall pred (car lst)) (drop-while pred (cdr lst)) lst))))

;(dolist-reverse '(a b c e f))

;(drop-while (lambda (x) t) '(a b c e f))
;(drop-while (lambda (x) nil) '(a b c e f))
;(drop-while (lambda (x) (not (eq x 'e))) '(a b c e f))

;(eq 'a (car '(a b c)))

(defun doc-mode-custom-keys () ""
       (progn
         (local-set-key (kbd "f2") 'rename-current-buffer-file)
         (local-set-key (kbd "M-p") 'doc-view-prev)
         (local-set-key (kbd "M-n") 'doc-view-next)
         (local-set-key (kbd "D") 'delete-file-current-buffer)
         (local-set-key (kbd "M-g r") 'doc-view-groosker-receipt)
         (local-set-key (kbd "M-g a") 'doc-view-groosker-avis)
         (local-set-key (kbd "M-p") 'doc-view-rename-letter)
         (local-set-key (kbd "C-c C-+") 'doc-view-enlarge)
         (local-set-key (kbd "C-c C--") 'doc-view-shrink)))


(setq-default ispell-program-name "aspell")

(defun doc-view-rename-letter ()
  (interactive)
  (rename-letter)
  (doc-view-kill-proc-and-buffer))

(defun doc-view-groosker-receipt ()
  (interactive)
  (groosker-receipt)
  (doc-view-kill-proc-and-buffer))

(defun doc-view-groosker-avis ()
  (interactive)
  (groosker-avis)
  (doc-view-kill-proc-and-buffer))

(add-hook 'doc-view-mode-hook 'doc-mode-custom-keys)

(defun amm ()
  (interactive)
  (ansi-term "amm"))

(defun mu ()
  (interactive)
  (mu4e))


(add-hook 'org-journal-mode-hook 'org-journal-custom-keys)

(defun org-journal-custom-keys () ""
       (progn
         (local-set-key (kbd "C-<return>") 'org-journal-simply-add-entry)))


(defun wdired-mode-custom-keys () ""
       (progn
         (local-set-key (kbd "RET") 'dired-find-file)
         (local-set-key (kbd "TAB") 'my-mark-file-name-forward)
         (local-set-key (kbd "<backtab>") 'my-mark-file-name-backward)))
         ;(local-set-key (kbd "M-m") 'my-mark-file-name-for-rename)))

(defun dired-mode-custom-keys () ""
       (progn
         (local-set-key (kbd "g") 'groosker)))

         ;(local-set-key (kbd "M-m") 'my-mark-file-name-for-rename)))

(defun my-mark-file-name-for-rename ()
    "Mark file name on current line except its extension"
    (interactive)

    ;; get the file file name first
    ;; full-name: full file name
    ;; extension: extension of the file
    ;; base-name: file name without extension
    (let ((full-name (file-name-nondirectory (dired-get-filename)))
          extension base-name)

      ;; check if it's a dir or a file
      ;; TODO not use if, use switch case check for symlink
      (if (file-directory-p full-name)
          (progn
            ;; if file name is directory, mark file name should mark the whole
            ;; file name
            (call-interactively 'end-of-line) ;move the end of line
            (backward-char (length full-name)) ;back to the beginning
            (set-mark (point))
            (forward-char (length full-name)))
        (progn
          ;; if current file is a file, mark file name mark only the base name,
          ;; exclude the extension
          (setq extension (file-name-extension full-name))
          (setq base-name (file-name-sans-extension full-name))
          (call-interactively 'end-of-line)
          (backward-char (length full-name))
          (set-mark (point))
          (forward-char (length base-name))))))

  (defun my-mark-file-name-forward ()
    "Mark file name on the next line"
    (interactive)
    (deactivate-mark)
    (next-line)
    (my-mark-file-name-for-rename))

  (defun my-mark-file-name-backward ()
    "Mark file name on the next line"
    (interactive)
    (deactivate-mark)
    (previous-line)
    (my-mark-file-name-for-rename))

(add-hook 'wdired-mode-hook 'wdired-mode-custom-keys)


;  (define-key wdired-mode-map (kbd "S-<tab>") 'my-mark-file-name-backward)
;  (define-key wdired-mode-map (kbd "s-a") 'my-mark-file-name-for-rename))


(setq doc-view-mode-hook nil)

;(defun eval-kill-ring ()
;  "Replace the preceding sexp with its value."
; (interactive)
; (backward-kill-sexp)
; (condition-case nil
;     (let ((k (current-kill 0)))
;       (kill-new (format "%s" (eval (read k))))
;       (insert k))
;   (error (message "Invalid expression")
;          (insert (current-kill 0)))))

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
    (if (use-region-p)
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

(defun yank-primary ()
  ""
  (interactive)
  (insert-string (x-get-selection 'PRIMARY 'STRING)))


(defun open-file-clipboard-primary ()
  ""
  (interactive)
  (find-file (string (x-get-selection 'PRIMARY 'STRING)))
  (string 231)

  (x-get-selection 'PRIMARY 'STRING))


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
               ("Helm" .       (lambda (dir) (go-to-project-and-browse dir)))
               ("Helm Browse Proeject" . (lambda (dir)
                                           (progn
                                             (cd dir)

                                           ;;(let ((default-directory (expand-file-name dir))
                                           ;;      (helm-default-directory dir))
                                           ;;  (message "helm root: %s - curr %s" (helm-ls-git-root-dir) (fboundp 'helm-ls-git-root-dir))
                                             (helm-browse-project t))))
               ("Jump" .       (lambda (dir) (cd dir)))
               ("Git status" . (lambda (dir) (git-status dir)))
               ("Git log" .    (lambda (dir) (git-log dir)))
               ))))))

(defun go-to-project-and-browse (dir)
  (progn
    (cd dir)
    (helm-browse-project dir)))

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

;(require 'helm-files)

(defun helm-branches (dir)
  (with-helm-default-directory dir
      (mapcar 'cons-same (car (git--branch-list)))))

(defun find-invoice () ""
       (interactive)
       (helm-find-files "/home/tbje/groosker/"))

(defun find-groosker () ""
       (interactive)
       (helm-find-files-1 "/home/tbje/groosker-files/"))

(defun find-scan () ""
       (interactive)
       (helm-find-files-1 "/home/tbje/scans/"))

(defun find-conf () ""
       (interactive)
       (helm-find-files-1 "/home/tbje/config/emacs/"))

(defun find-receipt () ""
       (interactive)
       (helm-find-files-1 "/home/tbje/groosker-files/Receipts/"))


(defun download () ""
       (interactive)
       (helm-find-files-1 "/home/tbje/Downloads/"))

(defun find-rec () ""
       (interactive)
       (helm-find-files-1 "/home/tbje/groosker-files/Receipts/"))



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
                                     "import scala.concurrent.duration._"
                                     "import akka.util.{ ByteString => BS, CompactByteString => CBS }"
                                     "def receive: Receive = { \ncase _ => \n}"
                                     "import com.efgfp.teleios.util._"
                                     "def receive: Receive = { case _ => }"
                                     "system.settings.config.get"
                                     )))
         (sources   '((name . "Scala common")
                      (candidates . cand)
                      (action . (("paste" . (lambda (x) x)))))))
    (insert (helm :sources sources
          :prompt "Select scala completion:"
          :buffer "*helm-spotify*"))
    (indent-according-to-mode)))

(defun helm-sbt-complete ()
  (interactive)
  (let* ((menu '(
                                     ("koan next" . nil)
                                     ("koan prev"  . nil)
                                     ("koan show" . nil)
                                     ("groll next" . nil)
                                     ("groll prev" . nil)
                                     ("groll show" . nil)
                                     ("groll list" . t)
                                     ("compile" . nil)
                                     ("gen-ensime" . nil)
                                     ("eclipse" . nil)
                                     ("test" . nil)
                                     ("test:compile" . nil)
                                     ("console" . t)
                                     ("consoleQuick" . t)
                                     ("run" . t)
                                     ("start" . nil)
                                     ("restart" . nil)
                                     ("reload" . nil)
                                     ))
         (cand (mapcar (lambda (x) `(,(car x) . (,(car x) . ,(cdr x)))) menu))
         ;;(cand (mapcar (lambda (x) (cons-same (car x))) menu))
         (sources   '((name . "SBT")
                      (candidates . cand)
                      (action . (("paste" . (lambda (x) (sbt:command (car x) (cdr x))))))))
    (insert (helm :sources sources
          :prompt "Select SBT command:"
          :buffer "*helm-spotify*")))))



(defun groll-move (start end)
  (interactive "r")
  (let ((str (find-string-active (use-region-p) start end (substring-no-properties (current-kill 0)))))
    (sbt:command (concat "groll move=" (read-from-minibuffer "Go to: " str)))))


;(defun pinentry-emacs (desc prompt ok error)
;  (let ((str (read-passwd (concat (replace-regexp-in-string "%22" "\"" (replace-regexp-in-string "%0A" "\n" desc)) prompt ": "))))
;    str))


(add-hook 'eshell-mode-hook
              (lambda ()
                (local-set-key (kbd "C-c h")
                               (lambda ()
                                 (interactive)
                                 (insert
                                  (ido-completing-read "Eshell history: "
                                                       (delete-dups
                                                        (ring-elements eshell-history-ring))))))
                (local-set-key (kbd "C-c C-h") 'eshell-list-history)))

(defvar last-run)


(defun ensime-sbt-do-run-last ()
  (interactive)
         (sbt-command (concat "runMain" " " last-run)))

(defun ensime-sbt-do-run-main ()
  (interactive)
  (let* ((impl-class
          (or (ensime-top-level-class-closest-to-point)
              (return (message "Could not find top-level class"))))
         (cleaned-class (replace-regexp-in-string "<empty>\\." "" impl-class))
         (command (concat "runMain" " " cleaned-class)))
    (setq last-run cleaned-class)
    (sbt-command command)))

(defun rename-sub-file ()
  (interactive)
  (let* ((orig (buffer-file-name))
         (scala (replace-regexp-in-string "java" "scala" orig))
         (mySMTP (replace-regexp-in-string "subethasmtp" "mySMTP" scala))
         (new (replace-regexp-in-string "org/subethamail" "com/github/tbje" mySMTP)))
    (write-file new)))
