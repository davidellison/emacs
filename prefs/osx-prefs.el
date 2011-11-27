;; some preferences for emacs on Mac OS X

;; add some things to the front of PATH so I can use python 2.7
(setenv "PATH" (concat "/usr/local:/usr/local/bin:" (getenv "PATH"))) ;; add /usr/local and /usr/local/bin to search path
(setq python-python-command "/usr/local/bin/python") ;; make "python" mean "python27 in /usr/local/bin"
(setq py-shell-name "/usr/local/bin/python")

;; command key should be meta
(setq mac-command-modifier 'meta)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;; add a couple Mac-style keybindings
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-z") 'undo)