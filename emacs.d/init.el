;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(defvar my-packages '(zenburn-theme
                      better-defaults
                      projectile
                      paredit
                      clojure-mode
                      clojure-mode-extra-font-locking
                      cider
                      company
                      emmet-mode
                      elpy))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; (load-theme 'tango-dark)
(load-theme 'zenburn t)

;; Spaces only (no tab characters at all)!
(setq-default indent-tabs-mode nil)

;; fullscreen
(custom-set-variables
  '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; for clojure python
(add-to-list 'load-path "~/.emacs.d/customizations")
(load "setup-clojure.el")
(load "setup-python.el")

;; for mac only
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
(global-set-key [f11] 'my-fullscreen)
(put 'upcase-region 'disabled nil)
