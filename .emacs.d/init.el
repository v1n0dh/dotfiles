;;; init.el --- Emacs configuration

;;; Commentary:

;;; code:

;;; Personal Information
(setq user-full-name "Vinodh Vinny"
      user-mail-address "vinodhvinny27@gmail.com")

;;; General Settings
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-splash-screen t)           ; disable startup screen
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq backup-directory-alist             ; save backup files and temporary files in /tmp
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(defalias 'yes-or-no-p 'y-or-n-p)
(prefer-coding-system 'utf-8)
(setq gc-cons-threshold 50000000)        ; increase memory before calling garbage collection
(setq large-file-warning-threshold 200000000)  ;; set large files warning to 200MB
(setq vc-follow-symlinks t)              ; always follow symlinks
(global-auto-revert-mode t)              ; auto update buffer to get sync

;;; Look and Feel
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'gotham t)
(set-face-attribute 'default nil :font "Hack" :height 90)
(setq-default tab-width 4
          indent-tabs-mode nil)
(setq column-number-mode t)
(setq default-cursor-type 'box)
(electric-pair-mode 1)
(show-paren-mode 1)
(size-indication-mode t)
(display-time-mode t)
(setq scroll-margin 0                      ; fix scrolling in emacs
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;;; Dired mode
(defun dired-mode-customization ()
    (put 'dired-find-alternate-file 'disabled nil)  ; use a instead of RET to navigate files
    (setq-default dired-listing-switches "-alh")    ; use human readable units
    (setq dired-recursive-copies 'always)           ; recursive copy
    (local-set-key (kbd "C-c d") 'dired-create-directory)
    (local-set-key (kbd "C-c f") 'dired-create-empty-file))

;;; Eshell mode
(defun eshell-mode-customization ()
  (company-mode -1)
  (display-line-numbers-mode -1))

;;; Global key bindings
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x n") 'display-line-numbers-mode)

;;; Global Hooks
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'dired-mode-hook 'dired-mode-customization)
(add-hook 'eshell-mode-hook 'eshell-mode-customization)
;(add-hook 'c-mode 'lsp)
;(add-hook 'c++-mode 'lsp)
;(add-hook 'java-mode-hook 'java-meghanada-mode-config)

;;; Initialize package source
(require 'package)
(add-to-list 'package-archives
         '("melpa" . "https://melpa.org/packages/") t)
;; security using tls while downloading packages
(require 'gnutls)
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

(use-package diminish
  :ensure t)

;;; Completion engine Ivy, Swiper and Counsel
(use-package ivy
  :ensure t
  :diminish
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  (use-package swiper
    :ensure t)
  (use-package counsel
    :ensure t))

(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

;;; Evil Mode customization
(use-package evil
  :ensure t
  :diminish
  :init
  (setq evil-insert-state-cursor 'box)
  :config
  (evil-mode 1)
  (use-package evil-surround
    :ensure t
    :config (global-evil-surround-mode)))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;;; Programming

;; Company for auto completion
(use-package company
  :diminish
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  :bind (:map company-active-map
              ("C-n" . company-select-next-or-abort)
              ("C-p" . company-select-previous-or-abort)))

;; Flycheck for syntax checking
(use-package flycheck
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save new-line)
        flycheck-idle-change-delay 5.0
        flycheck-display-errors-delay 0.9
        flycheck-highlighting-mode 'symbol
        flycheck-indication-mode 'left-fringe
        flycheck-standard-error-navigation t ;[M-g n/p]
        flycheck-deferred-syntax-check nil
        flycheck-mode-line '(:eval (flycheck-mode-line-status-text))))

;; Projectile for project management
(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-completion-system 'ivy)
  (setq-default
   projectile-mode-line
   '(:eval
     (if (file-remote-p default-directory)
         " Pr"
       (format "Pr[%s]" (projectile-project-name))))))

;; LSP setup
(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-print-io nil)
  ; lsp-ui gives documentation boxes and sidebar info
  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-sideline-ignore-duplicate t)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)))
  ; make sure we have lsp-imenu everywhere we have LSP
  ;(require 'lsp-ui-imenu)
  ;(add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

;; LSP backend for company-mode
(use-package company-lsp
  :ensure t)

;; C/C++ programming
(setq c-default-style "linux"
      c-basic-offset 4)

; ccls language server for C, C++
(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode) .
         (lambda () (require 'ccls) (lsp))))

;; go programming
(use-package go-mode
  :ensure t)

;; Java programming
(use-package lsp-java
  :ensure t
  :init
  (defun vinny/java-mode-config ()
    (lsp))
  :config
  (setq lsp-java-save-action-organize-imports nil)
  :hook
  (java-mode . vinny/java-mode-config)
  :after (lsp lsp-mode))

(use-package meghanada
  :ensure t)

(defun java-meghanada-mode-config ()
  (require 'meghanada)
  (meghanada-mode t)
  (flycheck-mode +1)
  ; use code format before save
  (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)
  (setq meghanada-java-path "java")
  (setq meghanada-maven-path "mvn"))


;;; init.el ends here
