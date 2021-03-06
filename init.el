;; Clean Look
(menu-bar-mode -1)
(tool-bar-mode -1)
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
                    :height 125
                    :weight 'normal
                    :width 'normal)

;; Quality of Life Improvements
(column-number-mode)
(setq word-wrap t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(setq custom-file (concat user-emacs-directory "/custom.el"))
(load-file custom-file)
(fset 'yes-or-no-p 'y-or-n-p)

;; Line Numbers
(require 'display-line-numbers)
(defcustom display-line-numbers-exempt-modes '(org-mode vterm-mode eshell-mode shell-mode term-mode ansi-term-mode elfeed-show-mode eww-mode)
  "Major modes on which to disable line numbers"
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "Turn on line numbers except on major modes defined in `display-line-numbers-exempt-modes'"
  (if (and
       (not (member major-mode display-line-numbers-exempt-modes))
       (not (minibufferp)))
      (display-line-numbers-mode)))
(global-display-line-numbers-mode)

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

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq initial-major-mode 'org-mode)

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

(use-package all-the-icons
  :ensure t)

(use-package mood-line
  :ensure t
  :hook (after-init . mood-line-mode))

(use-package weyland-yutani-theme
  :ensure t
  :config
  (load-theme 'weyland-yutani t))

(use-package smartparens
  :ensure t
  :init (require 'smartparens-config)
  :hook (prog-mode . smartparens-mode))

(use-package yaml-mode
  :ensure t)

(use-package vterm
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ivy
  :ensure t
  :bind ("C-s" . swiper)
  :config
  (setq ivy-use-virtual-buffers t
	ivy-count-format "(%d/%d) ")
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :config (counsel-mode 1))

(use-package swiper
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(use-package projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :custom ((projectile-completion-system 'ivy))
  :config (projectile-mode))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package magit
  :ensure t)

(use-package plantuml-mode
  :ensure t
  :config (setq plantuml-default-exec-mode 'jar
		plantuml-jar-path "/usr/share/java/plantuml.jar"
		org-plantuml-jar-path "/usr/share/java/plantuml.jar"))

(use-package org
  :ensure org-plus-contrib
  :pin org
  :config (setq org-ellipsis " ↴"
		org-hide-emphasis-markers t
		org-agenda-files '("~/Documents/org/birthdays.org"
				   "~/Documents/org/meetings.org"))
  (global-set-key (kbd "C-c s") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture)

  (setq org-special-ctrl-a/e t
	org-special-ctrl-k t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (plantuml . t)))
  (setq org-confirm-babel-evaluate nil)

  (require 'org-tempo)
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))

  (require 'ox-latex)
  (add-to-list 'org-latex-classes
		       '("moderncv"
			 "\\documentclass[11pt, a4paper]{moderncv}"
			 ("\\section{%s}" . "\\section*{%s}"))))

(use-package ox-hugo
  :ensure t
  :after ox)

(use-package elfeed
  :ensure t
  :config (setq elfeed-db-directory "~/.local/share/elfeed")
  :bind ("C-x w" . elfeed))

(use-package elfeed-org
  :ensure t
  :config (setq rmh-elfeed-org-files (list "~/Documents/org/feeds.org"))
  (elfeed-org))

(use-package olivetti
  :ensure t
  :config (setq olivetti-body-width 90)
  :hook (elfeed-show-mode . olivetti-mode))

(use-package all-the-icons-dired
  :ensure t
  :config (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  (setq all-the-icons-dired-monochrome nil))

(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-lAh --group-directories-first")
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  (define-key dired-mode-map "b" 'dired-up-directory))

(use-package helpful
  :ensure t
  :bind
  ("C-c C-d" . #'helpful-at-point)
  ("C-h k" . #'helpful-key)
  :config
  (setq counsel-describe-function-function #'helpful-callable
	counsel-describe-variable-function #'helpful-variable
	counsel-describe-symbol-function #'helpful-symbol))

(use-package eglot
  :ensure t)

(use-package avy
  :ensure t
  :bind
  ("C-:" . 'avy-goto-char)
  ("C-'" . 'avy-goto-char-2))

(use-package docker-tramp
  :ensure t)
