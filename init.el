;;;===============================================
;;; david's .emacs
;;;===============================================

;;--------------------------------------------
;;  load top level of my customizations
;;--------------------------------------------
(if (eq system-type 'windows-nt)
    (defvar home-directory "c:/Users/david/"))
(if (eq system-type 'darwin) ;; OS X
    (defvar home-directory "/Users/david/"))
(if (or (eq system-type 'linux)
	(eq system-type 'gnu/linux))
    (defvar home-director "/home/david/"))

(defvar emacs-root "~/emacs/")
(add-to-list 'load-path emacs-root) ;; load top emacs folder with my customizations

;;-------------------------------------------
;; my defuns & keybindings
;;-------------------------------------------
(add-to-list 'load-path (concat emacs-root "defuns"))
(load-library "my-keybindings")
(load-library "editing-defuns")
(load-library "my-defuns")

;;-------------------------------------------
;;  modes 
;;-------------------------------------------
(load-library "my-modes")

;;-------------------------------------------
;; my preferences
;;-------------------------------------------
(add-to-list 'load-path (concat emacs-root "prefs"))
(load-library "UI-prefs") ;; load settings 

(set-language-environment "UTF-8") ;; because i'm a linguist, i suppose

;;-------------------------------------------
;; my functions & OS-specific things
;;-------------------------------------------
(if (eq system-type 'darwin)
    (load-library "osx-defuns")) ;; for Mac OS X
(if (or (eq system-type 'windows-nt)
	(eq system-type 'cygwin))
    (load-library "windows-defuns")) ;; for Windows

;; load some other various preferences depending on OS
(if (eq system-type 'darwin)
    (load-library "osx-prefs"))
(if (or (eq system-type 'windows-nt)
	(eq system-type 'cygwin))
    (load-library "windows-prefs"))


(server-start)
(shell) ;; finally, run a shell (duh)