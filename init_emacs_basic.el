;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; BASIC CONFIGUATION OF EMACS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ,----
;; | UTF-8
;; `----
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
(set-clipboard-coding-system 'utf-16le-dos)


;; ,----
;; | Query Replace in open Buffers
;; `----
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


;; ,----
;; | Duplicate line
;; `----
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

;; ,----
;; | Beenden mit Nachfrage
;; `----
(setq kill-emacs-query-functions
      (cons (lambda () (y-or-n-p "Quit Emacs? "))
            kill-emacs-query-functions))

;; ,----
;; | Titlebar mit Dateiname
;; `----

(setq frame-title-format (concat "%f (%b) - %F " emacs-version))

;; ,----
;; |  Menu
;; `----

(require 'easymenu) 
(easy-menu-add-item nil 
                    (list (if (>= emacs-major-version 22) "Tools" "tools")) 
                    '("My Commands" 
                      ["Kill rectangle" kill-rectangle t] 
                      ["Sort lines" sort-lines t]))

 
;; ,----
;; | Diary
;; `----
;;Fancy display

;; Here is some code to make your calendar and diary display fancier:
(setq view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;; Here is some code to get rid of the ugly equal signs under the date:
(add-hook 'fancy-diary-display-mode-hook
          '(lambda ()
             (alt-clean-equal-signs)))

(defun alt-clean-equal-signs ()
  "This function makes lines of = signs invisible."
  (goto-char (point-min))
  (let ((state buffer-read-only))
    (when state (setq buffer-read-only nil))
    (while (not (eobp))
      (search-forward-regexp "^=+$" nil 'move)
      (add-text-properties (match-beginning 0) 
                           (match-end 0) 
                           '(invisible t)))
    (when state (setq buffer-read-only t))))

;; Diary Localization
;; German

;; Here's the code to make it all German. It changes the date format for
;; your diary entries to European style, makes Monday the first day of the
;; week, and changes weekday and month names.
                                        ;(european-calendar)
(setq calendar-week-start-day 1
      calendar-day-name-array
      ["Sonntag" "Montag" "Dienstag" "Mittwoch" 
       "Donnerstag" "Freitag" "Samstag"]
      calendar-month-name-array
      ["Januar" "Februar" "März" "April" "Mai" 
       "Juni" "Juli" "August" "September" 
       "Oktober" "November" "Dezember"])

;; ,----
;; | Boxquote
;; `----
(add-to-list 'load-path "~/.emacs.d/")
(require 'boxquote)

;; ,----
;; | Color Themes
;; `----
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(require 'color-theme)
(require 'birds-of-paradise-plus-theme)


;; ,----
;; | ASPELL
;; `----
;; (setq-default ispell-program-name "aspell")
(setq ispell-program-name "aspell") 

;; alist leeren und für aspell /de_DE.UTF-8 richtig eingestellen: 
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
