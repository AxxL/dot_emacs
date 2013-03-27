;; empty kill ring manually
;; M-: (setq kill-ring nil)
(add-to-list 'load-path "~/.emacs.d/")

;; ,----
;; | cygwin-mount
;; `----
(defconst +win-path+ "C:/" "Windows root path.")
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; Cygwin
(let ((cygwin-dir (concat +win-path+ "bin/cygwin/bin")))
  (when (file-exists-p cygwin-dir)
    (setq shell-file-name "bash"
          explicit-shell-file-name "bash")
    (setenv "SHELL" shell-file-name)
    (setenv "CYGWIN" "nodosfilewarning")

    (when (require 'cygwin-mount nil t)
      (cygwin-mount-activate)
      (setq w32shell-cygwin-bin cygwin-dir))))




;; icomplete mode
(setq icomplete-mode t)

;; ,----
;; | Speedbar *sigh*
;; `----
(require 'sr-speedbar)
 '(speedbar-show-unknown-files t)
 '(speedbar-use-images nil)

;; ,----
;; | Wikipedia Lookup
;; `----
;; Looks up current word in Wikipedia in a browser.  If a region is
;; active (a phrase), lookup hat phrase.
;; http://ergoemacs.org/emacs/elisp_idioms.html
(defun wikipedia-lookup ()
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (region-active-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))
    (setq myUrl
          (concat "http://de.wikipedia.org/wiki/Special:Search?search=" myWord))
    (browse-url myUrl)))

(defun leo-lookup ()
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (region-active-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))
    (setq myUrl
          (concat "http://dict.leo.org/?search=" myWord))
    (browse-url myUrl)))

(defun google-lookup ()
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (region-active-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))
    (setq myUrl
          (concat "http://www.google.de/search?q=" myWord))
    (browse-url myUrl)))


(defun arcgis-lookup ()
  (interactive)
  (let (myWord myUrl)
    (setq myWord
          (if (region-active-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (thing-at-point 'symbol)))
    (setq myUrl
          (concat "http://www.google.de/search?q=site:arcgis.com " myWord))
    (browse-url myUrl)))



;; ,----
;; | C-a (home) movement
;; | http://news.slashdot.org/comments.pl?sid=1021471&cid=25675361
;; `----
;;
;; Moves to beginning-of-line, or from there to the first non-whitespace
;; character.  This takes a numeric prefix argument when not 1, it behaves
;; exactly like \(move-beginning-of-line arg) instead.
(defun dev-studio-beginning-of-line (arg)
  (interactive "p")
  (if (and (looking-at "^") (= arg 1))
      (skip-chars-forward " \t") (move-beginning-of-line arg)))
(global-set-key "\C-a" 'dev-studio-beginning-of-line)
(global-set-key [home] 'dev-studio-beginning-of-line)


;; ,----
;; | Markdown mode
;; `----
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))


;; ,----
;; | Autopair
;; `----
(add-to-list 'load-path "~/.emacs.d/autopair")
(require 'autopair)
(autopair-global-mode)

;; ,----
;; | nyan-mode
;; `----
(add-to-list 'load-path "~/.emacs.d/nyan-mode")
(require 'nyan-mode)
(nyan-mode)


;; ,----
;; | IDO-Mode
;; | http://emacswiki.org/emacs/InteractivelyDoThings
;; `----
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)


;; ,----
;; | Testing interface
;; | http://whattheemacsd.com/init.el-01.html 
;; `----
;; Turn off mouse interface early in startup to avoid momentary display
;; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)


;; pretty prints the selection on a json document
;; uses python.
;; adjust the python path and executable.
;; see http://stackoverflow.com/questions/1548605/emacs-lisp-shell-command-on-region
(defun pretty-print-json(&optional b e)
  (interactive "r")
  (shell-command-on-region b e "c:/Python27/ArcGISx6410.1/python -m json.tool" (current-buffer) t)
)

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
;; (load "~/.emacs.d/tabbar.el")
;; (tabbar-mode 1)

;; ,----
;; | SOME KEYS
;; `----
;; indent-region
(global-set-key (kbd "C-M-ß") 'indent-region)
;; quote other window (default: C-x o)
(global-set-key (quote [C-tab]) (quote other-window))
;; USE: comment-dwim is bound to M-;.
;; (global-set-key (kbd "C-'") 'comment-or-uncomment-region)
;; (global-set-key (kbd "C-Ä") 'uncomment-region)


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
;; new in 1.2.1: 
;; Reverse the lines in the regions: Ctrl+~
;; Sort the regions: Meta+~
;; Insert line numbers: 【Hyper+~】

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
