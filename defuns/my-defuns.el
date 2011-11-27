;; various other function definitions

;; google query
(defun google ()
  "Googles a query (or the current region)"
  (interactive)
  (browse-url 
   (concat 
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (if mark-active 
	(buffer-substring (region-beginning) (region-end))
      (read-string "Google: ")))))

