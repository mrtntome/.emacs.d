;; Clean Look
(menu-bar-mode -1)
(tool-bar-mode 1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(fringe-mode 10)

;; Clean Startup
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "martin")
(setq initial-scratch-message "")

;; Set Default Font
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 110
                    :weight 'normal
                    :width 'normal)

;; Quality of Life Improvements
(setq word-wrap t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; store all backup and autosave files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq backup-by-copying t)

;; use ibuffer instead of buffer-menu
(defalias 'list-buffers 'ibuffer)

;; Package Manager
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(require 'use-package)
(setq use-package-always-ensure t)

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
