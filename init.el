;; TODO ORG-MODE Keys
; auto-complete-mode
; local-unset-key S-tab
; local-unset-key tab
; local-set-key S-tab org-cycle


;; pretty print xml region
(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    ;; split <foo><foo> or </foo><foo>, but not <foo></foo>
    (while (search-forward-regexp ">[ \t]*<[^/]" end t)
      (backward-char 2) (insert "\n") (incf end))
    ;; split <foo/></foo> and </foo></foo>
    (goto-char begin)
    (while (search-forward-regexp "<.*?/.*?>[ \t]*<" end t)
      (backward-char) (insert "\n") (incf end))
    (indent-region begin end nil)
    (normal-mode))
  (message "All indented!"))





;; empty kill ring manually
;; M-: (setq kill-ring nil)
(add-to-list 'load-path "~/.emacs.d/")

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Font
(if (eq system-type 'windows-nt)
    (progn
;; Turn off mouse interface early in startup to avoid momentary display
;; http://whattheemacsd.com/init.el-01.html 
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))


(set-face-attribute 'default nil :font "Bitstream Vera Sans Mono")
      ;; Color Themes
      (add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
      (require 'color-theme)

      ;; (require 'birds-of-paradise-plus-theme)
      ;; ;; the button seems not to work.
      ;; (custom-theme-set-faces
      ;;  'birds-of-paradise-plus
      ;;  `(button ((t (:background "#523D2B" :foreground "#D9D762" :underline t :weight bold))))
      ;;  )
      (require 'cyberpunk-theme)
      ) ; progn
)


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







