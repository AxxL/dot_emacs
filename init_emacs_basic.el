;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; BASIC CONFIGUATION OF EMACS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; UTF-8
;; http://blog.jonnay.net/archives/820-Emacs-and-UTF-8-Encoding.html
;; set up unicode
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; This from a japanese individual.  I hope it works.
(setq default-buffer-file-coding-system 'utf-8)
;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE
;; (set-clipboard-coding-system 'utf-16le-dos)


;; Highlight current line
;; (global-hl-line-mode 1)
;; To customize the background color
;; (set-face-background 'hl-line "#330")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keys, commands and functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Query Replace in open Buffers
(defun query-replace-in-open-buffers (arg1 arg2)
  "query-replace in open files"
  (interactive "sQuery Replace in open Buffers: \nsquery with: ")
  (mapcar
   (lambda (x)
     (find-file x)
     (save-excursion
       (beginning-of-buffer)
       (query-replace arg1 arg2)))
   (delq
    nil
    (mapcar
     (lambda (x)
       (buffer-file-name x))
     (buffer-list)))))



;; Duplicate line
(defun duplicate-line()
 "Duplicate line."
 (interactive)
 (let (
       (beg (line-beginning-position))
       (end (line-end-position)))
   (copy-region-as-kill beg end)
   (beginning-of-line)
   (forward-line 1)
   (yank)
   (newline)
   (forward-line -1)))
;; set key binding for duplicate-line
(global-set-key (kbd "C-c d") 'duplicate-line)

;; indent-region
(global-set-key (kbd "C-M-�") 'indent-region)
;; quote other window (default: C-x o)
(global-set-key (quote [C-tab]) (quote other-window))
(defun back-window ()
  (interactive)
  (other-window -1))
(global-set-key (quote [S-tab]) (quote back-window))

;; next-/previous-multiframe-windows doesn't work with Golden Mode
;; (global-set-key (quote [C-tab]) (quote next-multiframe-window))
;; (global-set-key (quote [S-tab]) (quote previous-multiframe-window))
;; USE: comment-dwim is bound to M-;.
;; (global-set-key (kbd "C-'") 'comment-or-uncomment-region)
;; (global-set-key (kbd "C-�") 'uncomment-region)

;; Unset C-tab for Org-Mode: Other Window
(add-hook 'org-mode-hook
          (lambda () 
            (local-unset-key [C-tab])))


;; C-a (home) movement
;; http://news.slashdot.org/comments.pl?sid=1021471&cid=25675361
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


;; Add Python to EXECPATH
(add-to-list 'exec-path "c:/bin/Python27/ArcGIS10.1")

;; pretty prints the selection on a json document
;; uses python.
;; adjust the python path and executable.
;; see http://stackoverflow.com/questions/1548605/emacs-lisp-shell-command-on-region
(defun pretty-print-json(&optional b e)
  (interactive "r")
  (shell-command-on-region b e "c:/Python27/ArcGISx6410.1/python -m json.tool" (current-buffer) t)
)


;; what-face
;; http://stackoverflow.com/questions/1242352/get-font-face-under-cursor-in-emacs
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; modes, customizations and other stuff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Beenden mit Nachfrage
(setq kill-emacs-query-functions
      (cons (lambda () (y-or-n-p "Quit Emacs? "))
            kill-emacs-query-functions))


;; Titlebar mit Dateiname
(setq frame-title-format (concat "%f (%b) - %F " emacs-version))


;; Menu
(require 'easymenu) 
(easy-menu-add-item nil 
                    (list (if (>= emacs-major-version 22) "Tools" "tools")) 
                    '("My Commands" 
                      ["Kill rectangle" kill-rectangle t] 
                      ["Sort lines" sort-lines t]))


;; ERC
(setq erc-hide-list '("JOIN" "PART" "QUIT"))


;; https://github.com/roman/golden-ratio.el/
(require 'golden-ratio)
(golden-ratio-mode 1)

;; ,----
;; | IDO-Mode
;; | http://emacswiki.org/emacs/InteractivelyDoThings
;; `----
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)


;; icomplete mode
(setq icomplete-mode t)


;; Speedbar, sr-speedbar
(require 'sr-speedbar)
'(speedbar-show-unknown-files t)
'(speedbar-use-images nil)
(global-set-key (quote [f11]) 'sr-speedbar-toggle)



;; CamelCase aware editing: enable for all programming modes
;; http://emacsredux.com/blog/2013/04/21/camelcase-aware-editing/
(add-hook 'prog-mode-hook 'subword-mode)



;; MULTIPLE CURSORS
;; new in 1.2.1: 
;; Reverse the lines in the regions: Ctrl+~
;; Sort the regions: Meta+~
;; Insert line numbers: ?Hyper+~?
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


;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Boxquote
(require 'boxquote)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Calendar and Diary
;; European calendar style, location (sunrise-sunset) and diary entries
(setq calendar-date-style 'european
      calendar-latitude 50.7
      calendar-longitude 7.1
      calendar-location-name "Bonn, NRW, GER"
      calendar-mark-diary-entries-flag t
      number-of-diary-entries 7)

(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; Diary Localization: German. Here's the code to make it all German. It
;; changes the date format for your diary entries to European style, makes
;; Monday the first day of the week, and changes weekday and month names.
(setq calendar-week-start-day 1
      calendar-day-name-array
      ["Sonntag" "Montag" "Dienstag" "Mittwoch" 
       "Donnerstag" "Freitag" "Samstag"]
      calendar-month-name-array
      ["Januar" "Februar" "M�rz" "April" "Mai" 
       "Juni" "Juli" "August" "September" 
       "Oktober" "November" "Dezember"])

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Aspell
;; (setq-default ispell-program-name "aspell")
(setq ispell-program-name "aspell") 

;; alist leeren und f�r aspell /de_DE.UTF-8 richtig eingestellen: 
(setq ispell-local-dictionary-alist nil) 
(add-to-list 'ispell-local-dictionary-alist 
	     '("deutsch8" 
 	       "[[:alpha:]]" "[^[:alpha:]]"
	       "[']" t
	       ("-C" "-d" "deutsch")
 	        "~latin1" iso-8859-1)
 	     )

(setq ispell-dictionary "deutsch8")
(setq ispell-local-dictionary "deutsch8")
(setq ispell-default-dictionary "deutsch8")
(setq flyspell-default-dictionary "deutsch8") 

(defun turn-on-flyspell-mode () 
   (flyspell-mode 1)
) 
