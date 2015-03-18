;;
;; BASIC CONFIGUATION OF EMACS
;;

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

;;
;; Org-mode
;;
(setq org-export-backends 
      '(ascii
        html
        icalendar
        latex
        md
        odt
        ))

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
;; Org Clocking?
;; http://www.orgmode.org/manual/Clocking-work-time.html
;;
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)


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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Aspell
;; (setq-default ispell-program-name "aspell")
(setq ispell-program-name "aspell") 

;; alist leeren und für aspell /de_DE.UTF-8 richtig eingestellen: 
(setq ispell-local-dictionary-alist nil) 
(add-to-list 'ispell-local-dictionary-alist 
	     '("deutsch8" 
 	       "[[:alpha:]]" "[^[:alpha:]]"
	       "[']" t
	       ("-C" "-d" "de_DE-neu.multi")
 	        "~latin1" iso-8859-1)
 	     )

(setq ispell-dictionary "deutsch8")
(setq ispell-local-dictionary "deutsch8")
(setq ispell-default-dictionary "deutsch8")
(setq flyspell-default-dictionary "deutsch8") 

;; (defun turn-on-flyspell-mode () 
;;    (flyspell-mode 1)
;; ) 
