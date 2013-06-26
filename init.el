;; empty kill ring manually
;; M-: (setq kill-ring nil)
(add-to-list 'load-path "~/.emacs.d/")

;; Turn off mouse interface early in startup to avoid momentary display
;; http://whattheemacsd.com/init.el-01.html 
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Font
(set-face-attribute 'default nil :font "Bitstream Vera Sans Mono")


;; Load external files
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
(load "~/.emacs.d/init_emacs_basic.el")
(load "~/.emacs.d/init_emacs_js.el")


;; Cygwin-Mount (doesn't work)
;; (defconst +win-path+ "C:/" "Windows root path.")
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; ;; Cygwin
;; (let ((cygwin-dir (concat +win-path+ "bin/cygwin/bin")))
;;   (when (file-exists-p cygwin-dir)
;;     (setq shell-file-name "bash"
;;           explicit-shell-file-name "bash")
;;     (setenv "SHELL" shell-file-name)
;;     (setenv "CYGWIN" "nodosfilewarning")

;;     (when (require 'cygwin-mount nil t)
;;       (cygwin-mount-activate)
;;       (setq w32shell-cygwin-bin cygwin-dir))))

;; (defun exec-logparser-utility ()
;;   (interactive)
;;   (shell-command "C:\Windows\SysWOW64\cmd.exe /k "C:\Program Files (x86)\Log Parser 2.2\LogParser.exe""))

;; ,----
;; | nyan-mode
;; `----
;; (add-to-list 'load-path "~/.emacs.d/nyan-mode")
;; (require 'nyan-mode)
;; (nyan-mode)







