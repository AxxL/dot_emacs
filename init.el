;; pretty prints the selection on a json document
;; uses python.
;; adjust the python path and executable.
;; see http://stackoverflow.com/questions/1548605/emacs-lisp-shell-command-on-region
(defun pretty-print-json(&optional b e)
  (interactive "r")
  (shell-command-on-region b e "c:/Python27/ArcGISx6410.1/python -m json.tool" (current-buffer) t)
)

;; Mumamo is making emacs 23.3 freak out:
(setq warning-minimum-level :error) 

;; Font
(set-face-attribute 'default nil :font "Bitstream Vera Sans Mono")

;; Load external files
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(load "~/.emacs.d/init_emacs_basic.el")

(load "~/.emacs.d/init_emacs_js.el")

;; ,----
;; | Add Python to EXECPATH
;; `----

(add-to-list 'exec-path "c:/bin/Python27/ArcGIS10.1")

;; ,----
;; | Tabbar
;; `----
(load "~/.emacs.d/tabbar.el")
(tabbar-mode 1)



;; ,----
;; | SOME KEY
;; `----
(global-set-key (quote [C-f10]) (quote indent-region))

;; ,----
;; | Org-Mode Other Window
;; `----
(add-hook 'org-mode-hook
          (lambda () 
            (local-unset-key [C-tab])))

;; ,----
;; | Highlight current line
;; `----
; (global-hl-line-mode 1)
;; To customize the background color
;; (set-face-background 'hl-line "#330")


;; ,----
;; | ERC
;; `----
(setq erc-hide-list '("JOIN" "PART" "QUIT"))


;; ,----
;; | SLIME SWANK-JS
;; `----
;; (global-set-key [f5] 'slime-js-reload)
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))


;; ,----
;; | MULTIPLE CURSORS
;; `----
(add-to-list 'load-path "~/.emacs.d/multiple-cursors/")
(require 'multiple-cursors)

;; When you have an active region that spans multiple lines, the following
;; will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but
;; based on keywords in the buffer, use:
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-d") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
