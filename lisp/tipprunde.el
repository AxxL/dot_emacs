;;
;; Tipprunde
;;
(defun wm-calc-pts (act erg)
  (if (or (not (string-match "-" act))
          (not (string-match "-" erg)))
      0
    (let ((a (string-to-number (car (split-string act "-"))))
          (b (string-to-number (cadr (split-string act "-"))))
          (x (string-to-number (car (split-string erg "-"))))
          (y (string-to-number (cadr (split-string erg "-")))))
      (cond
       ((and (= a x) (= b y)) 4)
       ((= (- b a) (- y x)) 3)
       ((or
         (and (> a b) (> x y))
         (and (< a b) (< x y))
         (and (= a b) (= x y))) 2)
       (t 0))))) 
