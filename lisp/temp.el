;;
;; empty kill ring manually
;; M-: (setq kill-ring nil)
;;

;; org-mode (https://github.com/sachac/emacs-notes/blob/gh-pages/baby-steps-org.org)
; (global-set-key (kbd "C-c a") 'org-agenda)
; (org-agenda nil "a")

;; TODO ORG-MODE Keys
; auto-complete-mode
; local-unset-key S-tab
; local-unset-key tab
; local-set-key S-tab org-cycle

;; JS3 mode
;; (add-to-list 'load-path "~/.emacs.d/js3-mode-master/")
;; (autoload 'js3-mode "js3" nil t)


;; ,----
;; | CUA-MODE
;; `----
;; (cua-mode 1)


;; ,----
;; | HIGHLIGHT CURRENT LINE
;; `----
;; (global-hl-line-mode 1)

;; next-/previous-multiframe-windows doesn't work with Golden Mode
;; (global-set-key (quote [C-tab]) (quote next-multiframe-window))
;; (global-set-key (quote [S-tab]) (quote previous-multiframe-window))
;; USE: comment-dwim is bound to M-;.
;; (global-set-key (kbd "C-'") 'comment-or-uncomment-region)
;; (global-set-key (kbd "C-Ä") 'uncomment-region)

;; Add Python to EXECPATH
;; (add-to-list 'exec-path "c:/bin/Python27/ArcGIS10.1")
;; pretty prints the selection on a json document
;; uses python.
;; adjust the python path and executable.
;; see http://stackoverflow.com/questions/1548605/emacs-lisp-shell-command-on-region

;; (global-set-key (kbd "C-c +") 'increment-number-at-point)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SQLi
;; http://www.emacswiki.org/emacs/SqlMode
;; (defvar sql-last-prompt-pos 1
;;   "position of last prompt when added recording started")
;; (make-variable-buffer-local 'sql-last-prompt-pos)
;; (put 'sql-last-prompt-pos 'permanent-local t)

;; (defun sql-add-newline-first (output)
;;   "Add newline to beginning of OUTPUT for
;;    `comint-preoutput-filter-functions' This fixes up the display
;;    of queries sent to the inferior buffer programatically."
;;   (let ((begin-of-prompt
;;          (or (and comint-last-prompt-overlay
;;                   ;; sometimes this overlay is not on prompt
;;                   (save-excursion
;;                     (goto-char (overlay-start comint-last-prompt-overlay))
;;                     (looking-at-p comint-prompt-regexp)
;;                     (point)))
;;              1)))
;;     (if (> begin-of-prompt sql-last-prompt-pos)
;;         (progn
;;           (setq sql-last-prompt-pos begin-of-prompt)
;;           (concat "\n" output))
;;       output)))

;; (defun sqli-add-hooks ()
;;   "Add hooks to `sql-interactive-mode-hook'."
;;   (add-hook 'comint-preoutput-filter-functions
;;             'sql-add-newline-first))
 
;; (add-hook 'sql-interactive-mode-hook 'sqli-add-hooks)

;; https://github.com/roman/golden-ratio.el/
;; (require 'golden-ratio)
;; (golden-ratio-mode 1)


;; Emacs Powerline
;; (add-to-list 'load-path "~/.emacs.d/emacs-powerline")
;; (require 'powerline)

;; You can choose between different arrow shapes:
;; (setq powerline-arrow-shape 'arrow)   ;; the default
;; (setq powerline-arrow-shape 'curve)   ;; give your mode-line curves
;; (setq powerline-arrow-shape 'arrow14) ;; best for small fonts

;; You can change the mode-line color using the standard method:
;; (custom-set-faces
;;  '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
;;  '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

;;
;; EMMS
;;
;; (emms-standard)
;; (emms-default-players) 


;; Fancy Display
; (add-hook 'diary-display-hook 'fancy-diary-display)

;; Here is some code to get rid of the ugly equal signs under the date:
;; (add-hook 'fancy-diary-display-mode-hook
;;           '(lambda ()
;;              (alt-clean-equal-signs)))

;; (defun alt-clean-equal-signs ()
;;   "This function makes lines of = signs invisible."
;;   (goto-char (point-min))
;;   (let ((state buffer-read-only))
;;     (when state (setq buffer-read-only nil))
;;     (while (not (eobp))
;;       (search-forward-regexp "^=+$" nil 'move)
;;       (add-text-properties (match-beginning 0) 
;;                            (match-end 0) 
;;                            '(invisible t)))
;;     (when state (setq buffer-read-only t))))

