(require 'todochiku)

(defun notify-via-libnotify (title body)
  "Notify with TITLE, BODY via `libnotify'."
  (call-process "notify-send" nil 0 nil
		title body 
                "-i" "notification-message-im" 
                "-t" "10" 
                "-u" "critical"))

(defun growl-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via growl"
    (if (jabber-muc-sender-p from)
        (notify-via-libnotify (format "(PM) %s"
                       (jabber-jid-displayname (jabber-jid-user from))
               (format "%s: %s" (jabber-jid-resource from) text)))
      (notify-via-libnotify (format "%s" (jabber-jid-displayname from))
             text)))

(add-hook 'jabber-alert-message-hooks 'growl-jabber-notify)

(notify-via-libnotify "Welcome master" "")
