;; some preferences for emacs on Windows

;; get textinfo files from cygwin
(add-to-list Info-default-directory-list "c:/cygwin/usr/share/info")

;; include cygwin tools
(if (or (eq system-type 'cygwin)
	(eq system-type 'windows-nt))
    (setenv "PATH" (concat ("c:\\cygwin\\bin;") (getenv "PATH"))))
