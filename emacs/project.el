
(defun jscala () "" (interactive) (find-file "~/jscala/jscala/src/main/scala/org/jscala"))
(defun jscala-test () "" (interactive) (find-file "~/jscala/jscala-examples/src/test/scala/org/jscalaexample"))

(defun zermex ()
  (interactive)
  (progn
    (let ((b (eshell "new")))
      (with-current-buffer b
        (eshell-command "cd /home/tbje/zermex" t)
        (eshell-command "sbt" t)))))
