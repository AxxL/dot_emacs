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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; SMEX
;;
(smex-initialize)

;;
;; yaml mode
;;
(require 'yaml-mode)

;;
;; simple wiki mode
;;
(require 'simple-wiki)

;;
;; Emacs Server
;;
                                        ;(server-start)

;;
;; AUTO-COMPLETE
;;
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)
;; (global-auto-complete-mode t)

;;
;; company mode
;;
(global-company-mode t)
(setq company-idle-delay 1)
(setq company-selection-wrap-around t)
;; remove annoying blinking
;; (setq company-echo-delay 0)
;; start autocompletion only after typing
;; (setq company-begin-commands '(self-insert-command))
;; Do not convert to lowercase
;; (setq company-dabbrev-downcase nil)


;;
;; saveplace
;; Remember the cursor position of files when reopening them
;;
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)
