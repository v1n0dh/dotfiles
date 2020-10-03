;; General Settings
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-splash-screen t)
(setq make-backup-files nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(set-face-attribute 'default nil :font "Hack" :height 90)
(global-linum-mode 1)
(setq column-number-mode t)
(setq default-cursor-type 'box)
(electric-pair-mode 1)
(show-paren-mode 1)
(prefer-coding-system 'utf-8)

;; Initialize package source
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
;; security using tls while downloading packages
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq gnutls-verify-error t)
(setq tls-checktrust t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install and initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package evil
  :diminish
  :init
  (setq evil-insert-state-cursor 'box)
  :config
  (evil-mode 1))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

;; c, c++ coding style
(setq c-default-style "linux")
