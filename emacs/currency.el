;;; -*- lexical-binding: t -*-
(require 'request)

(defcustom open-exchange-rates-api-key ""
  "API key for openexchangerates.org"
  :type 'string
  :group 'personal)

(defun get-exchange-date (date)
  "Get historical exchange rates for date format yyyy-mm-dd"
  (request
   (concat "http://openexchangerates.org/api/historical/" date ".json")
   :params `(("app_id" . ,open-exchange-rates-api-key))
   :parser 'json-read
   :success (function*
           (lambda (&key data &allow-other-keys)
             (let ((rates (assoc-default 'rates data)))
               (message (mapconcat 'identity (list
                         (str-convert rates 'CHF 'GBP)
                         (str-convert rates 'GBP 'CHF)
                         (str-convert rates 'NOK 'GBP)
                         (str-convert rates 'GBP 'NOK)
                         (str-convert rates 'NOK 'CHF)
                         (str-convert rates 'CHF 'NOK)) "\n")))))))

(defun get-exchange ()
  "Get latest exchange rates"
  (request
   "http://openexchangerates.org/api/latest.json"
   :params `(("app_id" . ,open-exchange-rates-api-key))
   :parser 'json-read
   :success (function*
           (lambda (&key data &allow-other-keys)
             (let ((rates (assoc-default 'rates data)))
               (message (concat
                         (str-convert rates 'CHF 'GBP) "\n"
                         (str-convert rates 'GBP 'CHF) "\n"
                         (str-convert rates 'NOK 'GBP) "\n"
                         (str-convert rates 'GBP 'NOK) "\n"
                         (str-convert rates 'NOK 'CHF) "\n"
                         (str-convert rates 'CHF 'NOK) "\n"
                         (str-convert rates 'USD 'CHF) "\n"
                         )))))))

(defun convert-callback (amount from to)
  (lexical-let ((strFn (lambda (rates)
                         (let* ((fromRate (assoc from rates))
                                (toRate (assoc to rates))
                                (newAmount (* amount (convert fromRate toRate))))
                           (kill-new (format "%s" newAmount))
                           (format "%s %s = %s %s" amount from newAmount to)))))
                         (function* (lambda (&key data &allow-other-keys)
                                      (lexical-let ((rates (assoc-default 'rates data)))
                                        (message "%s" (funcall strFn rates)))))))

                                        ; (strFn rates)))))))

(defun nok-chf (amount) (convert-from-to amount 'NOK 'CHF))
(defun btc-nok (amount) (convert-from-to amount 'BTC 'NOK))
(defun nok-eur (amount) (convert-from-to amount 'NOK 'EUR))
(defun nok-gbp (amount) (convert-from-to amount 'NOK 'GBP))
(defun nok-usd (amount) (convert-from-to amount 'NOK 'USD))
(defun chf-nok (amount) (convert-from-to amount 'CHF 'NOK))
(defun chf-usd (amount) (convert-from-to amount 'CHF 'USD))
(defun chf-gbp (amount) (convert-from-to amount 'CHF 'GBP))
(defun chf-eur (amount) (convert-from-to amount 'CHF 'EUR))
(defun eur-nok (amount) (convert-from-to amount 'EUR 'NOK))
(defun eur-chf (amount) (convert-from-to amount 'EUR 'CHF))
(defun gbp-nok (amount) (convert-from-to amount 'GBP 'NOK))
(defun gbp-chf (amount) (convert-from-to amount 'GBP 'CHF))
(defun usd-eur (amount) (convert-from-to amount 'USD 'EUR))
(defun eur-usd (amount) (convert-from-to amount 'EUR 'USD))
(defun usd-chf (amount) (convert-from-to amount 'USD 'CHF))
(defun usd-nok (amount) (convert-from-to amount 'USD 'NOK))

(defun eur-usd-d (amount date) (convert-from-to-date amount 'EUR 'USD date))
(defun eur-chf-d (amount date) (convert-from-to-date amount 'EUR 'CHF date))
(defun chf-usd-d (amount date) (convert-from-to-date amount 'CHF 'USD date))
(defun nok-chf-d (amount date) (convert-from-to-date amount 'NOK 'CHF date))
(defun usd-chf-d (amount date) (convert-from-to-date amount 'USD 'CHF date))
(defun chf-nok-d (amount date) (convert-from-to-date amount 'CHF 'NOK date))

(defun nok-chf-in ()
  (interactive)
  (backward-kill-sexp)
  (let ((k (current-kill 0)))
    (insert k)
    (nok-chf (read k))))

(defun chf-nok-in ()
  (interactive)
  (backward-kill-sexp)
  (let ((k (current-kill 0)))
    (insert k)
    (chf-nok (read k))))

;;(* 0.07 (+ (* 2.5 60000 ) 28000 (* 4 6000)))


(defun convert-from-to (amount from to)
  "Get latest exchange rates"
  (request
   "http://openexchangerates.org/api/latest.json"
   :params `(("app_id" . ,open-exchange-rates-api-key))
   :parser 'json-read
   :success (convert-callback amount from to)))

(defun convert-from-to-date (amount from to date)
  "Get historical exchange rates for date format yyyy-mm-dd"
  (request
   (concat "http://openexchangerates.org/api/historical/" date ".json")
   :params `(("app_id" . ,open-exchange-rates-api-key))
   :parser 'json-read
   :success (convert-callback amount from to)))


(defun str-convert (rates baseCur otherCur)
  (let ((base (assoc baseCur rates))
        (other (assoc otherCur rates)))
    (format "1 %s = %s %s" (car base) (convert base other) (car other))))

(defun convert (base other)
  (let* ((base-amount (cdr base))
         (other-amount (cdr other)))
    (/ other-amount base-amount)))


;;(nok-chf 1023)
;;(nok-eur 100)
;;(eur-nok 1000)

;; (nok-chf-d 1641 "2015-12-31") (67867.68708137327
;;(get-exchange-date "2015-05-13")
;;(get-exchange)
