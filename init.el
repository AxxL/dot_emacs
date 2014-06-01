;; TODO ORG-MODE Keys
; auto-complete-mode
; local-unset-key S-tab
; local-unset-key tab
; local-set-key S-tab org-cycle

;; (setq-default cursor-type 'bar)
;; (setq-default cursor-type 'box)

;; http://stackoverflow.com/questions/2007329/emacs-23-1-50-1-hangs-ramdomly-for-6-8-seconds-on-windows-xp

; try to improve slow performance on windows.
(setq w32-get-true-file-attributes nil)

(require 'tramp)
(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

;; JS3 mode
;; (add-to-list 'load-path "~/.emacs.d/js3-mode-master/")
;; (autoload 'js3-mode "js3" nil t)


;; empty kill ring manually
;; M-: (setq kill-ring nil)
(add-to-list 'load-path "~/.emacs.d/")

;; No splash screen please ... jeez
(setq inhibit-startup-message t)
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

; Melpa
(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)


;; Font
(if (eq system-type 'windows-nt)
    (progn
      ;; Turn off mouse interface early in startup to avoid momentary display
      ;; http://whattheemacsd.com/init.el-01.html 
      ;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
      ;; (load-theme 'cyberpunkaxxl t)
      ;; (load-theme 'cyberpunk t)
      ;; (load-theme 'zenburn t)
      ;; (load-theme 'solarized-dark t)
      ;; (load-theme 'birds-of-paradise-plus t)
      ) ; progn
  (progn
    (set-face-attribute 'default nil :font "Bitstream Vera Sans Mono" :height 95)
    ;; Color Themes
    (load-theme 'monokai t)
    )
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


;; &lt; to < and &gt; to >
;; http://ergoemacs.org/emacs/elisp_replace_string_region.html
(defun replace-html-anti-chars-region (start end)
  (interactive "r")
  (replace-pairs-region start end
                        '(
                          ["&amp;" "&"]
                          ["&lt;" "<"]
                          ["&gt;" ">"]
                          )))

(electric-pair-mode 1)
;; Autopair siehe elctric pair mode
;;   (require 'autopair)
;; (autopair-global-mode) ;; to enable in all buffers


;; Markdown mode playalong
;; (defun markdown2html(&optional b e)
;;   (interactive "r")
;;   (shell-command "c:/bin/cygwin/bin/perl.exe" (current-buffer) (concat default-directory "Readme.html"))
;; )
;; (global-hl-line-mode 1)


;; SQLi
;; http://www.emacswiki.org/emacs/SqlMode
(defvar sql-last-prompt-pos 1
  "position of last prompt when added recording started")
(make-variable-buffer-local 'sql-last-prompt-pos)
(put 'sql-last-prompt-pos 'permanent-local t)

(defun sql-add-newline-first (output)
  "Add newline to beginning of OUTPUT for
   `comint-preoutput-filter-functions' This fixes up the display
   of queries sent to the inferior buffer programatically."
  (let ((begin-of-prompt
         (or (and comint-last-prompt-overlay
                  ;; sometimes this overlay is not on prompt
                  (save-excursion
                    (goto-char (overlay-start comint-last-prompt-overlay))
                    (looking-at-p comint-prompt-regexp)
                    (point)))
             1)))
    (if (> begin-of-prompt sql-last-prompt-pos)
        (progn
          (setq sql-last-prompt-pos begin-of-prompt)
          (concat "\n" output))
      output)))

(defun sqli-add-hooks ()
  "Add hooks to `sql-interactive-mode-hook'."
  (add-hook 'comint-preoutput-filter-functions
            'sql-add-newline-first))
 
(add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)


;; ,----
;; | SUBLIMITY
;; `----
;; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; ;; (require 'sublimity-attractive)
