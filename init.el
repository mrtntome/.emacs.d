;; disable splash-screen
(setq inhibit-startup-screen t)

;; disable echo-area-message
(setq inhibit-startup-echo-area-message "martin")

;; disable scratch message
(setq initial-scratch-message "")


;; disable trunc words
(setq word-wrap t)

;; use ibuffer instead of buffer-menu
(defalias 'list-buffers 'ibuffer)

;; add melpa and package manager init
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; install and require use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; store all backup and autosave files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-by-copying t)

;; packages
(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package ace-window
  :ensure t
  :init (global-set-key [remap other-window] 'ace-window))


(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package smartparens
  :ensure t)

(use-package ox-hugo
  :ensure t
  :after ox)

(use-package yaml-mode
  :ensure t)


(menu-bar-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
