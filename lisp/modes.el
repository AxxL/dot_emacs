;;
;; mapserver-mode
;;
(add-to-list 'load-path "~/.emacs.d/lisp/mapserver-emacs-mode/")
(autoload 'mapserver-mode "mapserver-mode" "Mode for editing UMN MapServer files." t)
(add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))


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
;; ssh
(setq tramp-default-method "ssh")





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
;; flx-ido
;; https://github.com/lewang/flx
;;
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
;; (setq ido-use-faces nil)

;;
;; Speedbar, sr-speedbar
;;
;; (require 'sr-speedbar)
;; (make-face 'speedbar-face)
;; (set-face-font 'speedbar-face "Ubuntu Mono-12")
;; (setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))
;; (setq speedbar-show-unknown-files t)
;; (setq speedbar-use-images nil)
;; (setq speedbar-verbosity-level 0)

;;
;; Neotree
;;
(require 'neotree)

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

;;
;; WEB-MODE
;;
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig?\\'" . web-mode))


;; ,----
;; | Boxquote
;; `----
(require 'boxquote)


;;
;; YASNIPPET
;; installed by M-x list-packkages
;;
(require 'yasnippet)
(yas-global-mode 1)
;; Let's have snippets in the auto-complete dropdown
;; (add-to-list 'ac-sources 'ac-source-yasnippet)

;;
;; nyan-mode
;;
;; (require 'nyan-mode)
;; (nyan-mode)
