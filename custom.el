(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-view-program-selection
   (quote
    (((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Atril")
     (output-html "xdg-open"))))
 '(backup-directory-alist (quote (("." . "~/.emacs.d/.backups"))))
 '(blink-cursor-mode nil)
 '(case-fold-search t)
 '(column-number-mode t)
 '(csv-separators (quote (";" "," "	")))
 '(current-language-environment "German")
 '(default-input-method "german-postfix")
 '(fill-column 76)
 '(flymake-log-level 3)
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(load-home-init-file t t)
 '(make-backup-files t)
 '(mm-text-html-renderer (quote html2text))
 '(org-agenda-files (quote ("~/todo.org")))
 '(package-selected-packages
   (quote
    (plantuml-mode json-mode puppet-mode slack writeroom-mode color-theme-sanityinc-tomorrow web-mode yaml-mode olivetti htmlize browse-kill-ring ox-reveal mu4e-alert flycheck magit calfw imgur svg org-present epresent yasnippet use-package twig-mode sr-speedbar smex scss-mode sass-mode puml-mode projectile ox-mediawiki org-plus-contrib nyan-mode nginx-mode neotree multiple-cursors monokai-theme markdown-mode focus flx-ido fireplace csv-mode company boxquote birds-of-paradise-plus-theme auto-complete async 2048-game)))
 '(require-final-newline t)
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(speedbar-show-unknown-files t)
 '(speedbar-use-images nil)
 '(sql-product (quote postgres))
 '(tab-width 4)
 '(yaml-indent-offset 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
