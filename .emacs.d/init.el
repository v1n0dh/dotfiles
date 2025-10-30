;;; init.el --- Emacs configuration

;;; Commentary:

;;; code:

(add-to-list 'load-path "~/.emacs.d/init.el")

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
(global-display-line-numbers-mode t)

;;; Look and Feel
(setq org-src-fontify-natively t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'default-frame-alist '(alpha-background . 85)) ; For transparency
(load-theme 'solarized-dark t)
(set-face-attribute 'default nil :font "Terminus" :height 110)
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)
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

;;; Global Hooks
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'dired-mode-hook 'dired-mode-customization)
(add-hook 'eshell-mode-hook 'eshell-mode-customization)

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

(use-package gotham-theme
  :ensure t)

(use-package diminish
  :ensure t
  :config (which-key-mode))

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
(global-set-key (kbd "C-c f") 'counsel-projectile-find-file)
(global-set-key (kbd "C-c g") 'counsel-projectile-grep)
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

(use-package which-key
  :ensure t)

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
  (unless (file-remote-p  default-directory)
  (exec-path-from-shell-initialize)))

;;; Programming

;; Company for auto completion
(use-package company
  :diminish
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (setq lsp-completion-provider :capf)
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
  (setq lsp-print-io nil
        lsp-enable-file-watchers nil
        lsp-keep-workspace-alive nil
        lsp-auto-guess-root t)
  ; lsp-ui gives documentation boxes and sidebar info
  (use-package lsp-ui
    :ensure t
    :config
    (setq lsp-ui-sideline-ignore-duplicate t)
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)))
  ; make sure we have lsp-imenu everywhere we have LSP
  ;(require 'lsp-ui-imenu)
  ;(add-hook 'lsp-after-open-hook 'lsp-enable-imenu))

;; C/C++ programming
(setq c-default-style "linux"
      c-basic-offset 4)

; clangd language server for C, C++
(use-package lsp-clangd
  :ensure nil ;; bundled with lsp-mode
  :after lsp-mode
  :config
  (setq lsp-clients-clangd-executable "clangd"))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'linux_kernel_dev)

;; Tree-sitter Configuration
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (c "https://github.com/tree-sitter/tree-sitter-c")
     (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
     (rust "https://github.com/tree-sitter/tree-sitter-rust" "v0.23.3")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

(dolist (hook '(c-mode-hook c-ts-mode-hook
                c++-mode-hook c++-ts-mode-hook
                python-mode-hook python-ts-mode-hook
                rust-mode-hook rust-ts-mode-hook))
  (add-hook hook #'lsp))
(add-to-list 'auto-mode-alist '("[Mm]akefile\\'" . makefile-mode))

;;; Org-mode Configuration

(use-package org
  :ensure nil ; do not try to install it as it is built-in
  :mode ("\\.org\\'" . org-mode)
  :init
  (setq org-agenda-files '("~/Documents/Org_docs"))
  :hook
  ;; Enable nicer indentation and visual line wrapping
  ((org-mode . org-indent-mode)
   (org-mode . visual-line-mode))
  :config
  (setq org-M-RET-may-split-line '((default . nil)))
  (setq org-insert-heading-respect-content t)
  ;; Record a timestamp when marking tasks as done
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (electric-indent-mode -1)

  ;; Refresh org-agenda after rescheduling a task.
  (defun org-agenda-refresh (&rest _)
    "Refresh all `org-agenda' buffers."
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (derived-mode-p 'org-agenda-mode)
          (org-agenda-maybe-redo)))))

  (advice-add 'org-schedule :after #'org-agenda-refresh)

  ;; Set a different font for org headings
  (dolist (face '((org-level-1 . 1.3)
                  (org-level-2 . 1.2)
                  (org-level-3 . 1.15)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.05)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil
                        :font "Terminus"
                        :weight 'bold
                        :height (cdr face)))
  ;; custom org agenda view
  (setq org-agenda-custom-commands
        '(("v" "My Agenda View"
          ((agenda "" ((org-agenda-span 1)))
           (tags-todo "PRIORITY=\"A\""
                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                  (org-agenda-overriding-header "Top Priority Tasks:")))
           (tags-todo "PRIORITY=\"B\""
                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                  (org-agenda-overriding-header "Medium Priority Tasks:")))
           (tags-todo "PRIORITY=\"C\""
                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                  (org-agenda-overriding-header "Low Priority Tasks:")))
           (agenda "")
           (alltodo ""))))))

;; defining recurring tasks and easily scheduling them.
(use-package org-recur
  :ensure t
  :hook ((org-mode . org-recur-mode)
         (org-agenda-mode . org-recur-agenda-mode))
  :demand t
  :config
  ;; Keybindings for org-recur:
  (define-key org-recur-mode-map (kbd "C-c d") 'org-recur-finish)
  (define-key org-recur-agenda-mode-map (kbd "d") 'org-recur-finish)
  (define-key org-recur-agenda-mode-map (kbd "C-c d") 'org-recur-finish)

  ;; Mark finished recurring tasks as DONE and archive if you want:
  (setq org-recur-finish-done t
        org-recur-finish-archive t))

;; For nicer bullet points
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; Table of Contents
(use-package toc-org
  :ensure t
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

;; Useful global keybindings
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(use-package htmlize
  :ensure t
  :config (setq org-html-htmlize-output-type 'inline-css))

;;; init.el ends here
