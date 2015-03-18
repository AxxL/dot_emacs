;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; SPECIAL EMACS CUSTOMIZATIONS FOR JAVASCRIPT EDITING
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; ,----
;; | Open HTML with Firefox as default
;; `----
;; (setq browse-url-firefox-program "C:/Program Files (x86)/Mozilla Firefox/firefox.exe")
;; (setq browse-url-generic-program "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"
;;       browse-url-browser-function 'browse-url-generic) 

;; ,----
;; | BROWSE URL WITH URL NOT FILE PATH IN BROWSER
;; `----
;; http://www.emacswiki.org/emacs/BrowseUrl
;; 
;; (add-to-list 'browse-url-filename-alist
;;  '("/var/www/cgi/files/" . "http://my.website.com/cgi?"))


;; ,----
;; | NAV
;; `----
;; (add-to-list 'load-path "~/.emacs.d/emacs-nav-49/")
;; (require 'nav)
;; (nav-disable-overeager-window-splitting)
;; ;; Optional: set up a quick key to toggle nav
;; ;; (global-set-key [f11] 'nav-toggle)


;; ,----
;; | TEST
;; | HTML HELPER MODE
;; `----
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;; To invoke html-helper-mode automatically on .html files, do this:
;; (setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))


;; ,----
;; | PROJECT MODE
;; `----
;; (require 'project-mode)
;; (project-load-all) ; Loads all saved projects. Not required.

;; ,----
;; | FLYMAKE
;; `----
(when (load "flymake" t)
  (defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/node_modules/jshint/bin/jshint" (list local-file))))

  (setq flymake-err-line-patterns
        ;; tester.js: line 23, col 15, Expected ':' and instead saw '='.
        ;; "^\\(.*\\)\: line \\([[:digit:]]*\\), col [[:digit:]]*, \\(.*\\)$"
	(cons '("^\\(.*\\)\: line \\([[:digit:]]*\\), col [[:digit:]]*, \\(.*\\)$"
            1 2 nil 3)
	      flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\'" flymake-jslint-init))

  (require 'flymake-cursor)
  )

;; Turns on flymake for all files which have a flymake mode
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
(add-hook 'js-mode-hook
 	  (lambda ()
       (flymake-mode 1)
       (define-key js-mode-map "\C-c\C-n" 'flymake-goto-next-error)
       (define-key js-mode-map "\C-c\C-p" 'flymake-goto-prev-error)))


(add-hook 'js3-mode-hook
 	  (lambda ()
       (flymake-mode 1)
       (define-key js-mode-map "\C-c\C-n" 'flymake-goto-next-error)
       (define-key js-mode-map "\C-c\C-p" 'flymake-goto-prev-error)))


