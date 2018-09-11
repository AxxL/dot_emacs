;;
;; F5 kills buffer
;;
(global-set-key (kbd "<f5>") 'ido-kill-buffer)


;;
;; f6 join-line
;;
(global-set-key (kbd "<f6>") 'join-line)


;;
;; dead-circumflex ( ) dired-up-directory
;;
(global-set-key (kbd "<dead-circumflex>") 'dired-up-directory)


;;
;; window size keys
;;
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<down>") 'shrink-window)
(global-set-key (kbd "C-s-<up>") 'enlarge-window)


;;
;; indent region
;;
(global-set-key (kbd "C-M-ß") 'indent-region)


;;
;; quote other window (default: C-x o)
;;
;; Unset C-tab for Org-Mode: Other Window
(add-hook 'org-mode-hook
          (lambda () 
            (local-unset-key [C-tab])))
;; set key
(global-set-key (quote [C-tab]) (quote other-window))
(global-set-key (quote [f2]) (quote other-window))
(defun back-window ()
  (interactive)
  (other-window -1))
(global-set-key (quote [C-S-tab]) (quote back-window))
;; (global-set-key (quote [f3]) (quote back-window))


;;
;; set key binding for duplicate-line
;;
(global-set-key (kbd "C-c d") 'duplicate-line)

;;
;; C-a (home) movement
;;
(global-set-key "\C-a" 'dev-studio-beginning-of-line)
(global-set-key [home] 'dev-studio-beginning-of-line)

;;
;; IbufferMode
;;
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;
;; Sr-Speedbar
;;
;; (global-set-key (quote [f12]) 'sr-speedbar-toggle)
(global-set-key (quote [C-f12]) 'neotree-toggle)



;;
;; Multiple Cursors
;;
;; When you have an active region that spans multiple lines, the following
;; will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; When you want to add multiple cursors not based on continuous lines, but
;; based on keywords in the buffer, use:
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-d") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;;
;; Browse URL of File
;;
(global-set-key (quote [C-f11]) 'browse-url-of-file)


;; ,----
;; | magit
;; `----
(global-set-key (kbd "C-x g") 'magit-status)

