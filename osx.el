;;=======================================================
;; Elisp for using emacs with OSX
;;=======================================================

(message "===TRYING TO LOAD OSX STUFF (osx.el)===")

;;-------------------------------------------------
;; some preferences to make working in OSX easier
;;-------------------------------------------------
(setq mac-command-modifier 'meta) ;; use command key as Meta
;;(message "PUT /usr/local in PATH")
;;(setenv "PATH" (concat "/usr/local:/usr/local/bin:" (getenv "PATH"))) ;; look in /usr/local first for tools and things
;;(setenv "PATH" (concat "/Library/Frameworks/Python.
;;(message "look for python in /usr/loca/bin instead")
;;(setq py-shell-name "Libraries/Frameworks/Python.framework/Versions/2.7/bin/python")
;;(setq py-shell-name "/usr/local/bin/python")
;;(setq py-shell-name "python")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8) ;; play nicely with utf-8, of course

(global-set-key (kbd "M-s") 'save-buffer) ;; lastly, a couple mac-style keybindings: save, 
(global-set-key (kbd "M-z") 'undo) ;; ...and undo

;;-------------------------------------------
;; Functions for working with OSX
;;-------------------------------------------
(defun finder ()
  "Launch the finder in the current directory and select current file"
  (interactive)
  (shell-command
   (concat "open -R " (convert-standard-filename buffer-file-name))))
(global-set-key [f12] 'finder) ;; set F12 key to call this function

(defun open-with-eclipse ()
  "Open the current file in Eclipse."
  (interactive)
  (shell-command
   (concat "open -a /Users/david/tools/eclipse/Eclipse.app " "\"" (buffer-file-name) "\"")))

(defun open-with-textmate ()
  "Open the current file in TextMate."
  (interactive)
  (if (eq major-mode 'dired-mode)
      (shell-command "open .")
    (shell-command 
     (concat "open -a /Applications/TextMate.app " "\"" (buffer-file-name) "\""))))

(defun open-with-xcode ()
  "Open the current file in XCode"
  (interactive)
  (shell-command
   (concat "open -a /Developer/Applications/Xcode.app " "\"" (buffer-file-name) "\"")))


