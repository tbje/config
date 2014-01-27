(require 'jabber)
(setq jabber-account-list
`((,(car typesafe-jabber) (:network-server . "talk.google.com") (:password . ,(cadr typesafe-jabber)) (:port . 5223) (:connection-type . ssl))))

