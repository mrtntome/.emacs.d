;; disable splash-screen
(setq inhibit-startup-screen t)

;; disable echo-area-message
(setq inhibit-startup-echo-area-message "martin")

;; disable scratch message
(setq initial-scratch-message "")

;; disable toolbar, menubar and scrollbar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; disable trunc words
(setq word-wrap t)

;; use ibuffer instead of buffer-menu
(defalias 'list-buffers 'ibuffer)

;; use ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

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

(use-package spacemacs-theme
  :ensure t
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package julia-mode
  :ensure t)

(use-package spaceline
  :ensure t
  :config (spaceline-emacs-theme))

(use-package ace-window
  :ensure t
  :init (global-set-key [remap other-window] 'ace-window))

(use-package pdf-tools
  :ensure t)

(pdf-loader-install)

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package auctex
  :ensure t
  :defer t)

(use-package org-ref
  :ensure t
  :config
  (setq reftex-default-bibliography '("~/Documents/biblio/refs.bib"))
  (setq org-ref-bibliography-notes "~/Documents/biblio/notes.org"
	org-ref-default-bibliography '("~/Documents/biblio/refs.bib")
	org-ref-pdf-directory "~/Documents/biblio/pdfs/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auctex org-ref which-key use-package try spacemacs-theme spaceline pdf-tools org-bullets nlinum julia-mode exec-path-from-shell anaconda-mode ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
