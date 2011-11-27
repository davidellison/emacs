;; david's custom emacs keybindings

(global-set-key "\C-cs" 'shell)

(global-set-key "\C-cr" 'rename-uniquely)

(global-set-key "\C-cg" 'grep)

(global-set-key "\C-x\C-b" 'ibuffer)

(global-set-key "\C-x\C-m" 'execute-extended-command) ;; Meta
(global-set-key "\C-x\C-m" 'execute-extended-command)


;; keyboard aliases
(defalias 'qrr 'query-replace-regexp)
