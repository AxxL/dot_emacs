(setq user-mail-address "foo@bar.com")
(setq user-full-name "Foo Bar")

(setq gnus-select-method
      '(nnimap "mail-imap"
               (nnimap-address "mail-imap")
               (nnimap-server-port 143)
               (nnimap-stream starttls)
               ;; (nnimap-authenticator plain)
               ))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("mail-imap" 25 nil nil))
      smtpmail-auth-credentials '(("mail-imap" 25
                                   "foo@bar.com" nil))
      smtpmail-default-smtp-server "mail-imap"
      smtpmail-smtp-server "mail-imap"
      smtpmail-smtp-service 25)
      ;; Make Gnus NOT ignore [Gmail] mailboxes
      ;; gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")



;; ,----
;; | http://blog.binchen.org/posts/notes-on-using-gnus.html
;; `----
;; gnus-group-list-all-groups
(defun my-gnus-group-list-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5)
  )
(add-hook 'gnus-group-mode-hook
          ;; list all the subscribed groups even they contain zero un-read
          ;; messages
          (lambda () (local-set-key "o" 'my-gnus-group-list-subscribed-groups ))
          )

;; Auto complete email address when composing email
;; (add-hook 'message-mode-hook
;;           '(lambda ()
;;              (local-set-key "<TAB>" 'bbdb-complete-name)))

;; How to auto-complete email address
(add-hook 'message-mode-hook
          '(lambda ()
             (bbdb-initialize 'message)
             (bbdb-initialize 'gnus)
             (local-set-key "<TAB>" 'bbdb-complete-name)))

;; Summary Line
;; %U%R%z%I%(%[%4L: %-20,20n%]%) %s \n
;; (setq gnus-summary-line-format "%U%R%z%I%(%[%4L: %-20,20n%]%) %s \n")

;; (setq gnus-summary-line-format  "%d %U %R %z %I %(%[%4L: %-18,18n%]%) %s %e\n")




(setq-default
 ;;   gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
 gnus-summary-line-format "%U%R%z%&user-date; %I%(%[%4L: %-20,20n%]%) %s \n"
 gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M")))
 ;; gnus-summary-thread-gathering-function 'gnus-gather-treads-by-references
 ;; gnus-sum-thread-tree-false-root ""
 ;; gnus-sum-thread-tree-indent ""
 ;; gnus-sum-thread-tree-leaf-with-other "-> "
 ;; gnus-sum-thread-tree-root ""
 ;; gnus-sum-thread-tree-single-leaf "|_ "
 ;; gnus-sum-thread-tree-vertical "|")

(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)
        ))
