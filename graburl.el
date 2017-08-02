;;; graburl.el --- Tool to help me test url-retrieve-synchronously
;; Copyright 2017 by Dave Pearson <davep@davep.org>

;; Author: Dave Pearson <davep@davep.org>
;; Version: 1.0
;; Keywords: comm, net, http, web
;; URL: https://github.com/davep/graburl.el

;; This program is free software: you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation, either version 3 of the License, or (at your
;; option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
;; Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along
;; with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; `url-retrieve-synchronously' has behaved oddly for me from time to time,
;; having `point' settle in different places in the resulting buffer
;; depending on the site I'm pulling content from. This code has been
;; written so I can easily see where `point' ends up depending on what I
;; request, and how.
;;
;; This code really isn't useful for much else, and is unlikely to be useful
;; to anyone else. It's just a handy little debug/learning tool.

;;; code:

(require 'url-vars)

(defconst graburl-accept-types (list "text/plain" "text/html")
  "List of accept types.")

(defconst graburl-default-user-agent "GNU Emacs"
  "Default user agent to send to servers.")

(defun graburl (url accept user-agent)
  "Grab URL, accepting type ACCEPT, sending USER-AGENT."
  (interactive
   (list
    (read-string "URL: ")
    (completing-read "Accept: " graburl-accept-types nil nil (car graburl-accept-types) nil (car graburl-accept-types))
    (read-string "User agent: " graburl-default-user-agent nil graburl-default-user-agent)))
  (let ((url-mime-accept-string accept)
        (url-request-extra-headers `(("User-Agent" . ,user-agent))))
    (switch-to-buffer (url-retrieve-synchronously url t t))
    (set-buffer-multibyte t)))

(provide 'graburl)

;;; graburl.el ends here
