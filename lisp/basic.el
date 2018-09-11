;;
;; BASIC CONFIGUATION OF EMACS
;;

;;
;; Emacs Server
;;
(server-start)
(unless (server-running-p)
  (server-start))


;;
;; Beenden mit Nachfrage
;;
(setq kill-emacs-query-functions
      (cons (lambda () (y-or-n-p "Quit Emacs? "))
            kill-emacs-query-functions))


;;
;; Titlebar mit Dateiname
;;
(setq frame-title-format (concat "%f (%b) - %F " emacs-version))


;; ,----
;; | Org-mode
;; `----
;; (setq org-export-backends 
;;       '(ascii
;;         html
;;         icalendar
;;         latex
;;         md
;;         odt
;;         ))

;; Org Clocking?
;; http://www.orgmode.org/manual/Clocking-work-time.html
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


;;
;; Org-Agenda
;;
;; Start Org Agenda at startup
(add-hook 'after-init-hook 'org-agenda-list)
(setq initial-buffer-choice (lambda ()
    (get-buffer "*Org Agenda*")))  


;;
;; ERC
;;
(setq erc-hide-list '("JOIN" "PART" "QUIT"))



;;
;; GNUS
;;
;; GNUS can't send email error
(add-to-list 'exec-path "/usr/bin/")



;;
;; Filesystem and Webserver
;;
(setq browse-url-filename-alist
      '(("C:/inetpub/wwwroot/" . "http://mywindowsserver/")
        ("/home/aschaefer/public_html/" . "http://localhost/~aschaefer/"))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UTF-8
;; http://blog.jonnay.net/archives/820-Emacs-and-UTF-8-Encoding.html
;; set up unicode
;;
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
      ["Januar" "Februar" "März" "April" "Mai" 
       "Juni" "Juli" "August" "September" 
       "Oktober" "November" "Dezember"])




;;
;; show week numbers
;; http://emacswiki.org/emacs/CalendarWeekNumbers
;;

(copy-face font-lock-constant-face 'calendar-iso-week-face)
(set-face-attribute 'calendar-iso-week-face nil
                    :height 0.7)
(setq calendar-intermonth-text
      '(propertize
        (format "%2d"
                (car
                 (calendar-iso-from-absolute
                  (calendar-absolute-from-gregorian (list month day year)))))
        'font-lock-face 'calendar-iso-week-face))

(copy-face 'default 'calendar-iso-week-header-face)
(set-face-attribute 'calendar-iso-week-header-face nil
                    :height 0.7)
(setq calendar-intermonth-header
      (propertize "KW"                  ; or e.g. "KW" in Germany
                  'font-lock-face 'calendar-iso-week-header-face))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Aspell
(setq-default ispell-program-name "aspell")
(setq ispell-program-name "aspell"
      flyspell-default-dictionary "deutsch8"
      ispell-local-dictionary "deutsch8"
      ispell-silently-savep t
      )

;; alist leeren und für aspell /de_DE.UTF-8 richtig eingestellen: 
(setq ispell-local-dictionary-alist nil) 
(add-to-list 'ispell-local-dictionary-alist 
	     '("deutsch8" 
 	       "[[:alpha:]]" "[^[:alpha:]]"
           "[']" t
           ("-C" "-d" "de_DE-neu.multi")
           "~latin1" iso-8859-1)
       )

;; run flyspell-buffer after I added a word to my personal dictionary
;; https://www.reddit.com/r/emacs/comments/4oc7pg/spellcheck_flyspellmode_underlines_disappear_when/d4bj6tf/

(defun flyspell-buffer-after-pdict-save (&rest _)
  (flyspell-buffer))

(advice-add 'ispell-pdict-save :after #'flyspell-buffer-after-pdict-save)


;; (setq ispell-list-command "--list")


;; ENDE
;; (setq ispell-dictionary "deutsch8")
;; (setq ispell-default-dictionary "deutsch8")

;; (defun turn-on-flyspell-mode () 
;;    (flyspell-mode 1)
;; ) 


;; ,----
;; | Open HTML with Firefox as default
;; `----
;; (setq browse-url-firefox-program "C:/Program Files (x86)/Mozilla Firefox/firefox.exe")
(setq browse-url-generic-program "vivaldi"
      browse-url-browser-function 'browse-url-generic)


;;
;; Dired
;;
;; Dired Directories first
;; https://www.emacswiki.org/emacs/DiredSorting
(setq dired-listing-switches "-aBhl  --group-directories-first")
