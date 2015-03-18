;;
;; Projectile
;;
(projectile-global-mode)

;; Highlight current line
;; (global-hl-line-mode 1)
;; To customize the background color
;; (set-face-background 'hl-line "#330")

;;
;; Tramp
;;
(require 'tramp)
(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

;;
;; Menu
;;
(require 'easymenu) 
(easy-menu-add-item nil 
                    (list (if (>= emacs-major-version 22) "Tools" "tools")) 
                    '("My Commands" 
                      ["Kill rectangle" kill-rectangle t] 
                      ["Sort lines" sort-lines t]))


;;
;; electric pair mode (statt autopair-mode)
;;
(electric-pair-mode 1)

;;
;; icomplete mode
;;
(setq icomplete-mode t)

;;
;; CamelCase aware editing: enable for all programming modes
;; http://emacsredux.com/blog/2013/04/21/camelcase-aware-editing/
;;
(add-hook 'prog-mode-hook 'subword-mode)

;;
;; Ido
;; http://emacswiki.org/emacs/InteractivelyDoThings
;; Alt: (require 'ido) (ido-mode t) (setq ido-enable-flex-matching t)
;; flx-ido
;; https://github.com/lewang/flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
;; (setq ido-use-faces nil)

;;
;; Speedbar, sr-speedbar
;;
(require 'sr-speedbar)
'(speedbar-show-unknown-files t)
'(speedbar-use-images nil)


;;
;; MULTIPLE CURSORS
;; Reverse the lines in the regions: Ctrl+~
;; Sort the regions: Meta+~
;; Insert line numbers: ?Hyper+~?
;;
(add-to-list 'load-path "~/.emacs.d/multiple-cursors/")
(require 'multiple-cursors)


;;
;; Markdown mode
;;
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ,----
;; | Boxquote
;; `----
(require 'boxquote)
