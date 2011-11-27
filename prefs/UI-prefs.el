;;-------------------------------------
;; UI/Visual configuration settings
;;-------------------------------------

(defalias 'yes-or-no-p 'y-or-n-p)			;; yes/no ==> y/n
(column-number-mode t)					;; view col num too
(setq visible-bell t)					;; don't beep, it's annoying
(setq inhibit-startup-message t)			;; no splash screen
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))	;; no toolbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))	;; no scroll bar

(add-to-list 'load-path (concat emacs-root "color-theme-6.6.0"))
(require 'color-theme)
(color-theme-initialize)				;; set up color theme
(color-theme-charcoal-black)				;; and choose "charcoal black" scheme

(auto-compression-mode t)				;; look inside tarballs
(global-font-lock-mode t)
(show-paren-mode t)					;; highlight matching parentheses
(require 'uniquify)					;; unique buffer names

