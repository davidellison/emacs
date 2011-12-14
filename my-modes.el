;;-----------------------
;;  my extra emacs modes
;;-----------------------

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; w3m
(add-to-list 'load-path (concat emacs-root "emacs-w3m"))
(require 'w3m-load)
(setq w3m-command "/usr/local/bin/w3m")
(setq browse-url-browser-function 'w3m-browse-url)

;; python

;; python-mode
(message "*********loading python mode")
(add-to-list 'load-path (concat emacs-root "pythings/python-mode.el-6.0.3"))
(require 'python-mode)

;; ipython

;; pylookup

(add-to-list 'load-path (concat emacs-root "pythings/pylookup"))
(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")
(setq pylookup-program (concat emacs-root "pythings/pylookup/pylookup.py"))
(setq pylookup-db-file (concat emacs-root "pythings/pylookup/pylookup.db"))
(global-set-key "\C-ch" 'pylookup-lookup)

;; Magit (emacs interface to Git)
(add-to-list 'load-path (concat emacs-root "magit/"))
(require 'magit)

(require 'org-install) ;; org mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq default-major-mode 'org-mode)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (concat home-directory "org/agenda-files.txt"))

(add-to-list 'load-path (concat emacs-root "yasnippet"))
(require 'yasnippet)
(yas/initialize)
(setq yas/snippet-dirs (concat emacs-root "yasnippet/snippets"))

