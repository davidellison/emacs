;; function definitions for MS windows

(defun explorer ()
  "Launch the windows explorer in the current directory and selects current file"
  (interactive)
  (w32-shell-execute
   "open"
   "explorer"
   (concat "/e,/select," (convert-standard-filename buffer-file-name))))
(global-set-key [f12]         'explorer)        ; F12 - Open Explorer for the current file path

