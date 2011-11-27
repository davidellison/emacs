;; function definitions for OSX

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



      
      