(defun add-eww-bookmark ()
  (interactive)
  (bmkp-url-target-set eww-current-url 1 (replace-regexp-in-string "\n" " - " eww-current-title)))

(defcustom avoid-https nil "Use rather http than https for proxy reasons" :type 'boolean :group 'personal)

(defun google ()
  "Search google.com"
  (interactive)
  (ew-int "Search google" (concat (if avoid-https "http" "https") "://www.google.ch/search?q=" )))

(defun search ()
  "Search duck duck go"
  (interactive)
  (ew-int "Web search" eww-search-prefix))

(defun ew ()
  (interactive)
  (ew-int "Go to" ""))

(defun ew-int (prompt what)
  (let* ((killed (or (ignore-errors (current-kill 0 nil)) ""))
         (url
          (if (region-active-p)
              (buffer-substring (region-beginning) (region-end))
            (read-string (concat prompt " [" killed "]: ") nil nil killed))))
  (eww-browse-url (replace-regexp-in-string " " "+" (concat what url)))))

(defun extract-original-img-from-src ()
  (let ((reg "url_image\":\"\\([^\"]*\\)\","))
    (replace-regexp-in-string "\\\\/" "/" (first-match reg eww-current-source))))

(defun first-match (regexp str)
  (string-match regexp str)
  (match-string 1 str))

(defun next-img ()
  (interactive)
  (eww (first-match "imagenav-next-img\"[^<].*\n.*.*<a href=\"\\([^\"]*\\)\"" eww-current-source)))


  ;; (let ((a-url (format "http://ws.spotify.com/search/1/track.json?q=%s" search-term)))
  ;;   (with-current-buffer
  ;;       (url-retrieve-synchronously a-url)
  ;;     (goto-char url-http-end-of-headers)


(defun prev-img ()
  (interactive)
  (eww (first-match "imagenav-previous-img\"[^<].*\n.*.*<a href=\"\\([^\"]*\\)\"" eww-current-source)))

(defun org-image ()
  "Insert the image under point into the buffer."
  (interactive)
  (let ((url (extract-original-img-from-src)))
    (message "%s" url)
    (url-retrieve url 'shr-image-fetched
                  (list (current-buffer) (1- (point)) (point-marker))
                  t t)))

(defun next-import ()
  (interactive)
  (let ((b (current-buffer)))
    (next-img)
    (switch-to-buffer b)
    (org-image)))
