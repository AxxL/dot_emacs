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


;;
;; C-a (home) movement
;; http://news.slashdot.org/comments.pl?sid=1021471&cid=25675361
;;
;; Moves to beginning-of-line, or from there to the first non-whitespace
;; character.  This takes a numeric prefix argument when not 1, it behaves
;; exactly like \(move-beginning-of-line arg) instead.
;;
(defun dev-studio-beginning-of-line (arg)
  (interactive "p")
  (if (and (looking-at "^") (= arg 1))
      (skip-chars-forward " \t") (move-beginning-of-line arg)))


;;
;; what-face
;; http://stackoverflow.com/questions/1242352/get-font-face-under-cursor-in-emacs
;;
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))


;;
;; Pretty Print JSON. Needs Python
;;
(defun pretty-print-json(&optional b e)
  (interactive "r")
  (shell-command-on-region b e "/usr/bin/python3 -m json.tool" (current-buffer) t)
)


;;
;; pretty print xml region
;;
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


;;
;; replace html chars &lt; to < and &gt; to >
;; http://ergoemacs.org/emacs/elisp_replace_string_region.html
;;
(defun replace-html-anti-chars-region (start end)
  (interactive "r")
  (replace-pairs-region start end
                        '(
                          ["&amp;" "&"]
                          ["&lt;" "<"]
                          ["&gt;" ">"]
                          )))

;;
;; increment number at point
;;
(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

;;
;; decrement number at point
;;
(defun decrement-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1- (string-to-number (match-string 0))))))


;;
;; Shows XPath in modeline
;; http://www.emacswiki.org/emacs/NxmlMode
;;
(defun xpath-nxml-where ()
  "Display the hierarchy of XML elements the point is on as a path."
  (interactive)
  (let ((path nil))
    (save-excursion
      (save-restriction
        (widen)
        (while (and (< (point-min) (point)) ;; Doesn't error if point is at beginning of buffer
                    (condition-case nil
                        (progn
                          (nxml-backward-up-element) ; always returns nil
                          t)
                      (error nil)))
          (setq path (cons (xmltok-start-tag-local-name) path)))
        (if (called-interactively-p t)
            (message "/%s" (mapconcat 'identity path "/"))
          (format "/%s" (mapconcat 'identity path "/")))))))


;;
;; Wikipedia Lookup
;;
;; Looks up current word in Wikipedia in a browser.  If a region is
;; active (a phrase), lookup hat phrase.
;; http://ergoemacs.org/emacs/elisp_idioms.html
;;
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

;; dict.leo.org
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

;; google.de
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

;; arcgis.com
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

