;;
;; X? no tool-bar no scroll-bar
;;
(if (display-graphic-p)
    (progn
      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
      (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
      (if (fboundp 'scroll-bar-mode) (menu-bar-mode -1))
      )
  nil)

;;
;; Emacs Lisp Path
;;
(add-to-list 'load-path "~/.emacs.d/lisp")

;;
;; Melpa
;;
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

;;
;; OS-adjustments
;;
(if (eq system-type 'windows-nt)
    (progn
      ;; http://stackoverflow.com/questions/2007329/emacs-23-1-50-1-hangs-ramdomly-for-6-8-seconds-on-windows-xp
      ;; try to improve slow performance on windows.
      (setq w32-get-true-file-attributes nil))
  nil )

;;
;; X or console?
;;
(if (display-graphic-p)
    (progn
      ;; (set-face-attribute 'default nil :font "Bitstream Vera Sans Mono" :height 95)
      (set-face-attribute 'default nil :font "Ubuntu Mono" :height 120)
      ;; Color Themes
      (load-theme 'monokai t)
      ;; (load-theme 'cyberpunkaxxl t)
      ;; (load-theme 'cyberpunk t)
      ;; (load-theme 'zenburn t)
      ;; (load-theme 'solarized-dark t)
      ;; (load-theme 'birds-of-paradise-plus t)
      ;; (setq-default cursor-type 'bar)
      ;; (setq-default cursor-type 'box)
      ) ; progn
  nil )


;;
;; Load external files
;;
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(load "~/.emacs.d/lisp/basic.el")
(load "~/.emacs.d/lisp/modes.el")
(load "~/.emacs.d/lisp/functions.el")
(load "~/.emacs.d/lisp/keys.el")
;; (load "~/.emacs.d/init_emacs_js.el")

;;
;; SMEX
;;
(smex-initialize)


;;
;; nyan-mode
;;
(require 'nyan-mode)
(nyan-mode)

;;
;; mapserver-mode
;;
(add-to-list 'load-path "~/.emacs.d/lisp/mapserver-emacs-mode/")
(autoload 'mapserver-mode "mapserver-mode" "Mode for editing UMN MapServer files." t)
(add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))

;;
;; window size keys
;;
(global-set-key (kbd "s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-<down>") 'shrink-window)
(global-set-key (kbd "s-<up>") 'enlarge-window)

;;
;; yaml mode
;;
(require 'yaml-mode)


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
;; simple wiki mode
;;
(require 'simple-wiki)

;;
;; Emacs Server
;;
(server-start)

;;
;; Emacs Tramp
;;
(setq tramp-default-method "ssh")


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



;;
;; GNUS
;;
;; GNUS can't send email error
(add-to-list 'exec-path "/usr/bin/")


;;
;; Org Clocking?
;; http://www.orgmode.org/manual/Clocking-work-time.html
;;
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


;;
;; AUTO-COMPLETE
;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

;;
;; YASNIPPET
;; installed by M-x list-packkages
;;
(require 'yasnippet)
(yas-global-mode 1)
;; Let's have snippets in the auto-complete dropdown
(add-to-list 'ac-sources 'ac-source-yasnippet)

