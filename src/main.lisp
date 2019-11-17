(defpackage #:yubin
  (:use #:cl)
  (:import-from #:quri #:make-uri)
  (:import-from #:jonathan #:parse)
  (:import-from #:dexador)
  (:export #:get-place))
(in-package #:yubin)

(defun get-place (zipcode)
  (let* ((url (quri:make-uri :defaults "http://zipcloud.ibsnet.co.jp/api/search"
                             :query `(("zipcode" . ,zipcode)))) ; QuriでURLを作る
         (response (parse (dex:get url)))                       ; HTTPリクエストを行う
         (result (first (getf response :|results|))))
    (if result
        (concatenate 'string
                    (getf result :|address1|)
                    (getf result :|address2|)
                    (getf result :|address3|))
        (error (format nil "~A: ~S"
                       (getf response :|message|)
                       zipcode)))))

;; blah blah blah.
