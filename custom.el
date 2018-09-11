(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
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
 '(org-agenda-files (quote ("~/todo.org")))
 '(package-selected-packages
   (quote
    (browse-kill-ring markdown-toc htmlize ox-reveal mu4e-maildirs-extension flymd calfw-org color-theme-sanityinc-tomorrow neotree magit rainbow-mode plantuml-mode flymake-cursor pdf-tools solarized-theme json-mode auctex mu4e-alert flycheck calfw svg org-present yasnippet yaml-mode web-mode use-package twig-mode smex scss-mode sass-mode puml-mode projectile php-mode ox-mediawiki org-plus-contrib nyan-mode multiple-cursors monokai-theme markdown-mode focus flx-ido csv-mode company boxquote birds-of-paradise-plus-theme auto-complete async)))
 '(puml-plantuml-jar-path "/home/aschaefer/bin/plantuml/plantuml.jar")
 '(require-final-newline t)
 '(show-paren-mode t)
 '(show-paren-style (quote mixed))
 '(sql-product (quote postgres))
 '(tab-width 2)
 '(yaml-indent-offset 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-inline-code-face ((t (:inherit markdown-code-face :height 0.8))))
 '(markdown-pre-face ((t (:inherit (markdown-code-face font-lock-constant-face) :height 0.8))))
 '(markdown-table-face ((t (:inherit markdown-code-face :height 0.8))))
 '(neo-dir-link-face ((t (:foreground "deep sky blue" :slant normal :weight bold :height 90 :family "Ubuntu"))))
 '(neo-file-link-face ((t (:foreground "White" :weight normal :height 90 :family "Ubuntu"))))
 '(neo-root-dir-face ((t (:foreground "lightblue" :weight bold)))))
