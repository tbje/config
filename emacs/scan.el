
(defun scan-front ()
  ""
  (interactive)
  (let* (
         (day (string-to-number (format-time-string "%d")))
         (month (string-to-number (format-time-string "%m")))
         (id (trim-string (shell-command-to-string "/home/tbje/bin/gen")))
         (dir "/home/tbje/scans/todo/")
         (name-prefix (format "%02d%02d-%s" month day id))
         (name (concat (get-name-receipt name-prefix "pdf"))))
    (shell-command (format "scan --dest %s %s" dir name))
    (find-file (format "%s%s" dir name))))

(defun scan-both ()
  ""
  (interactive)
  (let* (
         (day (string-to-number (format-time-string "%d")))
         (month (string-to-number (format-time-string "%m")))
         (id (trim-string (shell-command-to-string "/home/tbje/bin/gen")))
         (dir "/home/tbje/scans/todo/")
         (name-prefix (format "%02d%02d-%s" month day id))
         (name (concat (get-name-receipt name-prefix "pdf"))))
    (shell-command (format "scan -d --dest %s %s" dir name))
    (find-file (format "%s%s" dir name))))

(defun scan ()
  ""
  (interactive)
  (let* (
         (current-day (string-to-number (format-time-string "%d")))
         (current-month (string-to-number (format-time-string "%m")))
         (day (read-number "day: " current-day))
         (month (read-number "month: " current-month))
         (company (completing-read "Company: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-companies) nil nil ""))
         (what (completing-read "What: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-descriptions) nil nil ""))
         (name-prefix (format "%02d%02d-%s-%s" month day company what))
         (name (concat (get-name-receipt name-prefix "pdf")))
         (dir  (completing-read "personal or groosker: [p] " '(("personal" 1) ("groosker" 1) ("p" 1) ("g" 1)) nil t "" nil "p"))
         (type (completing-read "front, back, duplex or interactive: [f] " '(("front" 1) ("duplex" 1) ("back" 1) ("f" 1) ("d" 1) ("b" 1) ("i" 1)) nil t "" nil "front")))
    (setq scan-day day
          scan-month month
          scan-company company
          scan-what what
          scan-dir dir
          scan-type type)
    (shell-command (format "scan %s --dest %s %s" (duplex-cmd-line type) (chose-dir dir) name))
    (find-file (format "%s%s" (chose-dir dir) name))))

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun scan-restart ()
  ""
  (interactive)
  (let* (
         (day (read-number "day: " scan-day))
         (month (read-number "month: " scan-month))
         (company (completing-read "Company: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-companies) nil nil scan-company))
         (what (completing-read "What: "
                                   (mapcar (lambda (a) `(,a . 1)) letter-descriptions) nil nil scan-what))
         (name-prefix (format "%02d%02d-%s-%s" month day company what))
         (name (concat (get-name-receipt name-prefix "pdf")))
         (dir  (completing-read "personal or groosker: " '(("personal" 1) ("groosker" 1) ("p" 1) ("g" 1)) nil t scan-dir nil scan-dir))
         (type (completing-read "front back or duplex: " '(("front" 1) ("duplex" 1) ("back" 1) ("f" 1) ("d" 1) ("b" 1)) nil t scan-type nil "f")))
    (setq scan-day day
          scan-month month
          scan-company company
          scan-what what
          scan-dir dir
          scan-type type)
    (shell-command (format "scan %s --dest %s %s" (duplex-cmd-line type) (chose-dir dir) name))
    (find-file (format "%s%s" (chose-dir dir) name))))

(defvar scan-day)
(defvar scan-month)
(defvar scan-company)
(defvar scan-what)
(defvar scan-dir)
(defvar scan-type)
