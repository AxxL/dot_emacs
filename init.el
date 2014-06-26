;; X? no tool-bar no scroll-bar
(if (display-graphic-p)
    (progn
      (if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
      (if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
      )
  nil)

;; empty kill ring manually
;; M-: (setq kill-ring nil)
(add-to-list 'load-path "~/.emacs.d/")

; Melpa
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; OS-adjustments
(if (eq system-type 'windows-nt)
    (progn
      ;; http://stackoverflow.com/questions/2007329/emacs-23-1-50-1-hangs-ramdomly-for-6-8-seconds-on-windows-xp
      ;; try to improve slow performance on windows.
      (setq w32-get-true-file-attributes nil))
  nil )


;; X or console?
(if (display-graphic-p)
    (progn
      (set-face-attribute 'default nil :font "Bitstream Vera Sans Mono" :height 95)
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


;; ,----
;; | mapserver-mode
;; `----
(autoload 'mapserver-mode "mapserver-mode" "Mode for editing UMN MapServer files." t)
(add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))


;; ,----
;; | window size keys
;; `----
(global-set-key (kbd "s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-<down>") 'shrink-window)
(global-set-key (kbd "s-<up>") 'enlarge-window)


;; ,----
;; | yaml mode
;; `----
(add-to-list 'load-path "~/.emacs.d/yaml-mode/")
(require 'yaml-mode)


;; ,----
;; | F5 kills buffer
;; `----
(global-set-key (kbd "<f5>") 'ido-kill-buffer)


;; ,----
;; | Tipprunde
;; `----
(defun wm-calc-pts (act erg)
  (if (or (not (string-match "-" act))
          (not (string-match "-" erg)))
      0
    (let ((a (string-to-number (car (split-string act "-"))))
          (b (string-to-number (cadr (split-string act "-"))))
          (x (string-to-number (car (split-string erg "-"))))
          (y (string-to-number (cadr (split-string erg "-")))))
      (cond
       ((and (= a x) (= b y)) 4)
       ((= (- b a) (- y x)) 3)
       ((or
         (and (> a b) (> x y))
         (and (< a b) (< x y))
         (and (= a b) (= x y))) 2)
       (t 0))))) 

;; TODO ORG-MODE Keys
; auto-complete-mode
; local-unset-key S-tab
; local-unset-key tab
; local-set-key S-tab org-cycle

;; JS3 mode
;; (add-to-list 'load-path "~/.emacs.d/js3-mode-master/")
;; (autoload 'js3-mode "js3" nil t)
