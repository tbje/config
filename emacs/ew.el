(defun add-eww-bookmark ()
  (interactive)
  (bmkp-url-target-set eww-current-url 1 (replace-regexp-in-string "\n" " - " eww-current-title)))

(defun google ()
  "Search google.com"
  (interactive)
  (ew-int "Search google" "https://www.google.ch/search?q="))

(defun search ()
  "Search duck duck go"
  (interactive)
  (ew-int "Web search" eww-search-prefix))

(defun ew ()
  (interactive)
  (ew-int "Go to" ""))

(defun ew-int (prompt what)
  (let* ((killed (current-kill 0 nil))
         (url
          (if (region-active-p)
              (buffer-substring (region-beginning) (region-end))
            (read-string (concat prompt " [" killed "]: ") nil nil killed))))
  (eww-browse-url (replace-regexp-in-string " " "+" (concat what url)))))
