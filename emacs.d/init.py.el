;; from http://aaronbedra.com/emacs.d/
;; User details
(setq user-full-name "Phoenix Zhang")
(setq user-mail-address "pho.coderzhang@gmail.com")

;; Environment
(setenv "PATH" (concat "/usr/local/bin" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/bin")))
(require 'cl)

;; Package Management
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; Define default packages
(defvar phoenix/packages '(solarized-theme
                           elpy
                           yaml-mode
			   autopair
			   org)
  "Default packages")

;; Install default packages
(defun phoenix/packages-installed-p ()
  (loop for pkg in phoenix/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (phoenix/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg phoenix/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; Start-up options
;; Splash Screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Scroll bar, Tool bar, Menu bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Marking text
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; Display Settings
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Indentation
(setq tab-width 2
      indent-tabs-mode nil)

;; Backup files
(setq make-backup-files nil)

;; Yes and No
(defalias 'yes-or-no-p 'y-or-n-p)

;; Key bindings
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;; Utilities
;; Column number mode
(setq column-number-mode t)

;; autopair-mode
(require 'autopair)
(autopair-global-mode)

;; Language Hooks
;; Python
(elpy-enable)

;; YAML
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; Themes
(if window-system
    (load-theme 'solarized-light t)
  (load-theme 'wombat t))

;; Color Codes
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
