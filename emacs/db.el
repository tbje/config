;; (set-variable 'groosker-db-params '("user" "db" "pw"))

(defun groosker-db () ""
  (interactive)
  (set-variable 'sql-user (car groosker-db-params)) ;; See secret.el
  (set-variable 'sql-database (cadr groosker-db-params))
  (set-variable 'sql-password (caddr groosker-db-params))
  (sql-mysql)
)

(defun typesafe-db () ""
  (interactive)
  (set-variable 'sql-user (car typesafe-db-params))
  (set-variable 'sql-database (cadr typesafe-db-params))
  (set-variable 'sql-password (caddr typesafe-db-params))
  (sql-mysql)
)
