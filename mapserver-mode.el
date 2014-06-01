;; mapserver-mode-el -- Major mode for editing UMN MapServer files

;; Author: Hal Mueller <hal@mobilegeographics.com>
;; Created: 22 May 2004
;; Keywords: MapServer major-mode

;; Copyright (C) 2004 Hal Mueller <hal@mobilegeographics.com>
;; (distributed under the standard MapServer license)
;; Permission is hereby granted, free of charge, to any person obtaining a copy of 
;; this software and associated documentation files (the "Software"), to deal in 
;; the Software without restriction, including without limitation the rights to use, 
;; copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the 
;; Software, and to permit persons to whom the Software is furnished to do so, subject 
;; to the following conditions:

;; The above copyright notice and this permission notice shall be included in all 
;; copies of this Software or works derived from this Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS 
;; FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
;; COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
;; IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;;; Commentary:
;;
;; This mode is for editing .MAP configuration files used by the UMN MapServer.
;; Current version of this mode can be found at http://www.mobilegeographics.com/mapserver/
;; The MapServer software itself is at http://mapserver.gis.umn.edu/
;;
;; Usage:  add these lines to your .emacs file:
;; (autoload 'mapserver-mode "mapserver-mode" "Mode for editing UMN MapServer files." t)
;; (add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))
;;
;; and of course install this file (mapserver-mode.el) in a directory in your load-path.
;;
;; Known bugs:
;;   constructs of the form PROJECTION "xxx" "yyy" "zzz" END break the indentation.  Instead, use
;;      PROJECTION
;;        "xxx" "yyy" "zzz"
;;      END
;;
;;   The bug is probably in the function 'mapserver-indent-line.


;;; Code:
(defvar mapserver-mode-hook nil)
(defvar mapserver-mode-map
  (let ((mapserver-mode-map (make-keymap)))
    (define-key mapserver-mode-map "\C-j" 'newline-and-indent)
    mapserver-mode-map)
  "Keymap for MapServer major mode")

(add-to-list 'auto-mode-alist '("\\.map\\'" . mapserver-mode))
(add-to-list 'auto-mode-alist '("\\.MAP\\'" . mapserver-mode))

;;;(setq xyzzy (regexp-opt '("END" "MAP" "LAYER" "PROJECTION" "STYLE" "CLASS" "QUERYMAP" "LEGEND" "REFERENCE" "SCALEBAR" "WEB" "FEATURE" "POINTS" "JOIN" "OUTPUTFORMAT" "FONTSET") t))
(defconst mapserver-font-lock-keywords-1
  (list
   ;; These define the beginning and end of each MapServer entity definition
   ;; END
   ;; CLASS FEATURE FONTSET JOIN LAYER LEGEND MAP OUTPUTFORMAT POINTS PROJECTION QUERYMAP REFERENCE SCALEBAR TEMPLATE STYLE WEB
   '("\\<\\(CLASS\\|END\\|F\\(?:EATURE\\|ONTSET\\)\\|JOIN\\|L\\(?:AYER\\|EGEND\\)\\|MAP\\|OUTPUTFORMAT\\|P\\(?:OINTS\\|ROJECTION\\)\\|QUERYMAP\\|REFERENCE\\|S\\(?:CALEBAR\\|TYLE\\)\\|WEB\\)\\>" . font-lock-builtin-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for MapServer mode.")

(defconst mapserver-font-lock-keywords-2
  (append mapserver-font-lock-keywords-1
	  (list
	   ;; These are some possible attributes of MapServer entities
	   ;; "COLOR" "MAXSIZE" "MINSIZE" "OFFSET" "OUTLINECOLOR" "TRANSPARENT" "BACKGROUNDCOLOR" "ANTIALIAS" "NAME"
	   '("\\<\\(COLOR\\|MAXSIZE\\)\\>" . font-lock-keyword-face)
	   '("\\<\\(ON\\|OFF\\)\\>" . font-lock-constant-face)))
  "Additional Keywords to highlight in MapServer mode.")

(defconst mapserver-font-lock-keywords-3
  (append mapserver-font-lock-keywords-2
	  (list
	   ;; These are some possible built-in values for MapServer attributes
	   ;; POINT POLYGON LINE
	   '("\\<(LINE\\|PO\\(?:INT\\|LYGON\\))\\>" . font-lock-constant-face)))
  "Balls-out highlighting in MapServer mode.")

(defvar mapserver-mode-tab-width 4)
(defvar mapserver-font-lock-keywords mapserver-font-lock-keywords-3
  "Default highlighting expressions for MapServer mode.")

(defun mapserver-indent-line ()
  "Indent current line as MapServer code."
  (interactive)
  (beginning-of-line)
  (if (bobp)
      (indent-line-to 0)	   ; First line is always non-indented
    (let ((not-indented t) cur-indent)
	(if (looking-at "^[ \t]*END") ; If the line we are looking at is the end of a block, then decrease the indentation
	    (progn
	      (save-excursion
		(forward-line -1)
		(setq cur-indent (- (current-indentation) mapserver-mode-tab-width)))
	      (if (< cur-indent 0) ; We can't indent past the left margin
		  (setq cur-indent 0)))
	  (save-excursion
	    (while not-indented	; Iterate backwards until we find an indentation hint
	      (forward-line -1)
	      (if (looking-at "^[ \t]*END") ; This hint indicates that we need to indent at the level of the END_ token
		  (progn
		    (indent-according-to-mode)
		    (setq cur-indent (current-indentation))
		    (setq not-indented nil))
		;; CLASS FEATURE FONTSET GRID JOIN LAYER LEGEND MAP OUTPUTFORMAT POINTS PROJECTION QUERYMAP REFERENCE SCALEBAR STYLE WEB
		(if (or (looking-at "^SYMBOL$")
			(looking-at "^[ \t]*\\(CLASS\\|FEATURE\\|FONTSET\\|GRID\\|JOIN\\|LABEL\\b\\|LAYER\\|LEGEND\\|MAP\\|METADATA\\|OUTPUTFORMAT\\|POINTS\\|PROJECTION\\|QUERYMAP\\|REFERENCE\\|SCALEBAR\\|SYMBOL\\|STYLE\\|WEB\\)"))	; This hint indicates that we need to indent an extra level
		    (progn
		      (setq cur-indent (+ (current-indentation) mapserver-mode-tab-width)) ; Do the actual indenting
		      (setq not-indented nil))
		  (if (bobp)
		      (setq not-indented nil)))))))
    (if cur-indent
	(indent-line-to cur-indent)
      (indent-line-to 0))))) ; If we didn't see an indentation hint, then allow no indentation

(defvar mapserver-mode-syntax-table
  (let ((mapserver-mode-syntax-table (make-syntax-table)))

    ;; This is added so entity names with underscores can be more easily parsed
    (modify-syntax-entry ?_ "w" mapserver-mode-syntax-table)
    (modify-syntax-entry ?# "<" mapserver-mode-syntax-table)
    (modify-syntax-entry ?\n ">" mapserver-mode-syntax-table)
    

    mapserver-mode-syntax-table)
  "Syntax table for mapserver-mode")

(defun mapserver-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map mapserver-mode-map)
  (set-syntax-table mapserver-mode-syntax-table)
  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(mapserver-font-lock-keywords))
  ;; Register our indentation function
  (set (make-local-variable 'indent-line-function) 'mapserver-indent-line)
  (set (make-local-variable 'tab-width) mapserver-mode-tab-width)
  (setq major-mode 'mapserver-mode)
  (setq mode-name "MapServer")
  (run-hooks 'mapserver-mode-hook))

(provide 'mapserver-mode)

;;; mapserver-mode.el ends here
