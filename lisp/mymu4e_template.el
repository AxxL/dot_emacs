;; ,----
;; | mu4e
;; `----
;;
;; Commands:
;; $ offlineimap
;; $ mu index --maildir=/home/aschaefer/Dokumente/imapmailcd
;; 
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")
(require 'mu4e)

;; Only needed if your maildir is _not_ ~/Maildir
;; Must be a real dir, not a symlink
(setq mu4e-maildir "~/Dokumente/imapmail"
      mu4e-sent-folder   "/INBOX.Sent"
      mu4e-drafts-folder "/INBOX.Drafts"
      mu4e-trash-folder  "/INBOX.Trash")

;; Retrieval and indexing
(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 300)

;; SMTP
;; smtp mail setting; these are the same that `gnus' uses.
(setq
   message-send-mail-function   'smtpmail-send-it
   smtpmail-default-smtp-server "imap.axxl.loc"
   smtpmail-smtp-server         "imap.axxl.loc"
   smtpmail-local-domain        "axxl.loc"
   ;; smtpmail-stream-type         'starttls
   smtpmail-smtp-service        25)

(setq mm-coding-system-priorities '(mule-utf-8 iso-latin-1 iso-latin-9))

;; a list of user's e-mail addresses
;; (setq mu4e-user-mail-address-list '("axxl@axxl.loc"))
;; (setq user-mail-address '("axxl@axxl.loc"))
;; (setq user-mail-address "axxl@axxl.loc")
(setq user-full-name "AxxL")
(setq user-mail-address "axxl@axxl.loc")
;; (setq mail-host-address "axxl.loc")
(setq mu4e-compose-dont-reply-to-self t)
      
;; To protect yourself from sending messages too hastily, you can add a
;; final confirmation, which you can of course make as elaborate as you
;; wish.
(add-hook 'message-send-hook
  (lambda ()
    (unless (yes-or-no-p "Sure you want to send this?")
      (signal 'quit nil))))

;; Signature
(setq mu4e-compose-signature (get-string-from-file "~/Dokumente/signatur_lang.txt"))
;; (setq message-signature-file "~/Dokumente/signatur_lang.txt")

;; Attachements
(setq mu4e-attachment-dir  "~/Downloads")

;; Number of lines shown in the header view (default: 8).
(setq mu4e-headers-visible-lines 20)

;; Test
;; (setq mymaildirstring (substring :maildir 7))

(setq mu4e-headers-fields
    '( (:human-date    .  20)    ;; alternatively, use :human-date
       (:flags         .   4)
       (:from          .  25)
       (:subject       .  nil)
       (:maildir       . 20))) ;; alternatively, use :thread-subject


(setq mu4e-headers-date-format "%a %d.%m.%Y %H:%M") ; date format

;; Html2text functions; If mu4e-html2text-command refers to an elisp
;; function, it is expected to take the current buffer in html as input, and
;; transform it into text (just like the html2text function). For example,
;; emacs 24.4 and later versions include the eww browser which uses the shr
;; html renderer; mu4e includes a little snippet to uses this with
;; mu4e-html2text-command; for this, add the following to your
;; configuration:
;; mu4e-html2text-command "html2text -utf8 -width 72"
(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text)
;; (setq mu4e-view-prefer-html t)

;; If you use the mu4e-shr2text, it might be useful to emulate some of the
;; shr key bindings, with something like:
(add-hook 'mu4e-view-mode-hook
  (lambda()
    ;; try to emulate some of the eww key-bindings
    (local-set-key (kbd "<tab>") 'shr-next-link)
    (local-set-key (kbd "<backtab>") 'shr-previous-link)))

;; If you’re using a dark theme, and the messages are hard to read, it can
;; help to change the luminosity, e.g.:
;; (setq shr-color-visible-luminance-min 80)


;; enable inline images
(setq mu4e-view-show-images t
      mu4e-view-image-max-width 800)
;; use imagemagick, if available
;; (when (fboundp 'imagemagick-register-types)
;;   (imagemagick-register-types))

;; Bookmarks
(add-to-list 'mu4e-bookmarks
             (make-mu4e-bookmark
              :name  "Unread filtered"
              :query "flag:unread and not maildir:/INBOX.tracker.gitlab and not maildir:/INBOX.tracker.github and not maildir:/INBOX.mailinglisten.qgis-user and not maildir:/INBOX.mailinglisten.geonetwork-users"
              :key ?n)
             )

;; Searches
(setq mu4e-maildir-shortcuts
      '( ("/INBOX" . ?i)
         ;; ("/archive" . ?a)
         ;; ("/lists" . ?l)
         ;; ("/work" . ?w)
         ("/INBOX.Drafts" . ?d)
         ("/INBOX.Sent" . ?s)))

;; Normally, mu4e _buries_ the message buffer after sending; if you want to
;; kill the buffer instead, add something like the following to your
;; configuration:
(setq message-kill-buffer-on-exit t)

;; when set to t, only consider addresses that were seen in personal messages
;; – that is, messages in which one of my e-mail addresses was seen in one
;; of the address fields. This is to exclude mailing list posts. You can
;; define what is considered ’my e-mail address’ using
;; mu4e-user-mail-address-list, a list of e-mail address (defaults to
;; user-mail-address, and when indexing from the command line, the
;; --my-address parameter for mu index.
;; (setq mu4e-compose-complete-only-personal t)


;; (setq mu4e-confirm-quit nil)

;; (setq mu4e-use-fancy-chars t)


;; Choose the style you prefer for desktop notifications
;; If you are on Linux you can use
;; 1. notifications - Emacs lisp implementation of the Desktop Notifications API
;; 2. libnotify     - Notifications using the `notify-send' program, requires `notify-send' to be in PATH
;;
;; On Mac OSX you can set style to
;; 1. notifier      - Notifications using the `terminal-notifier' program, requires `terminal-notifier' to be in PATH
;; 1. growl         - Notifications using the `growl' program, requires `growlnotify' to be in PATH
(setq mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
;; (setq mu4e-alert-enable-notifications t)
;; (setq mu4e-alert-enable-mode-line-display t)

;; spell-checking for mail-composing
;; https://github.com/iqbalansari/dotEmacs/blob/master/config/mail.org
;; (add-hook 'message-mode-hook 'flyspell-mode)
;; (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)


;; ,----
;; | bash Befehle
;; `----
;; offlineimap
;; mu index --maildir=/home/aschaefer/Dokumente/imapmail


