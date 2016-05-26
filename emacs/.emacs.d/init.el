;;; init.el

;;;; General initialization


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'pallet)

(require 's)
(require 'f)
(require 'use-package)
(require 'bind-key)

;;;; UI / misc

(use-package better-defaults)

(global-auto-revert-mode 1)
(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq show-trailing-whitespace t)
(set-frame-font "Terminus-8" nil t)
(windmove-default-keybindings)

(bind-key "C-x <up>" 'next-multiframe-window)
(bind-key "C-x <down>" 'previous-multiframe-window)

(use-package idle-highlight-mode
  :config (add-hook 'prog-mode-hook 'idle-highlight-mode))

(use-package powerline
  :config (use-package moe-theme
            :init (progn
                    (setq calendar-latitude +60)
                    (setq calendar-longitude +25))
            :config (progn
                      (moe-theme-set-color 'green)
                      (powerline-moe-theme)
                      (moe-dark))))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq custom-file "~/.emacs-custom.el")
(load custom-file)

(custom-set-faces
 '(prodigy-red-face ((((class color)) (:foreground "#ff4b4b"))))
 '(prodigy-yellow-face ((((class color)) (:foreground "#fce94f"))))
 '(prodigy-green-face ((((class color)) (:foreground "#afff00")))))

;;;; Non-language packages

(use-package projectile
  :config (projectile-global-mode))

(use-package smex
  :config (smex-initialize)
  :bind ("M-x" . smex))

(use-package emacs-lisp-mode
  :mode ("Cask" . emacs-lisp-mode))

(use-package smartparens
  :init (smartparens-global-mode)
  :bind (("C-M-a" . sp-beginning-of-sexp)
         ("C-M-e" . sp-end-of-sexp)
         ("C-<down>" . sp-down-sexp)
         ("C-<up>"   . sp-up-sexp)
         ("M-<down>" . sp-backward-down-sexp)
         ("M-<up>"   . sp-backward-up-sexp)
         ("C-M-f" . sp-forward-sexp)
         ("C-M-b" . sp-backward-sexp)
         ("C-M-n" . sp-next-sexp)
         ("C-M-p" . sp-previous-sexp)
         ("C-S-f" . sp-forward-symbol)
         ("C-S-b" . sp-backward-symbol)
         ("C-<right>" . sp-forward-slurp-sexp)
         ("M-<right>" . sp-forward-barf-sexp)
         ("C-<left>"  . sp-backward-slurp-sexp)
         ("M-<left>"  . sp-backward-barf-sexp)
         ("C-M-t" . sp-transpose-sexp)
         ("C-M-k" . sp-kill-sexp)
         ("C-k"   . sp-kill-hybrid-sexp)
         ("M-k"   . sp-backward-kill-sexp)
         ("C-M-w" . sp-copy-sexp)
         ("C-M-d" . delete-sexp)
         ("M-<backspace>" . backward-kill-word)
         ("C-<backspace>" . sp-backward-kill-word)
         ([remap sp-backward-kill-word] . backward-kill-word)
         ("M-[" . sp-backward-unwrap-sexp)
         ("M-]" . sp-unwrap-sexp)
         ("C-x C-t" . sp-transpose-hybrid-sexp)
         ("C-c ("  . wrap-with-parens)
         ("C-c ["  . wrap-with-brackets)
         ("C-c {"  . wrap-with-braces)
         ("C-c '"  . wrap-with-single-quotes)
         ("C-c \"" . wrap-with-double-quotes)
         ("C-c _"  . wrap-with-underscores)
         ("C-c `"  . wrap-with-back-quotes)))

(use-package popwin
  :config (popwin-mode 1))

(use-package company
  :config (global-company-mode))

(use-package undo-tree
  :config (global-undo-tree-mode))

(use-package easy-kill
  :bind ([remap kill-ring-save] . easy-kill))

(use-package editorconfig
  :config (editorconfig-mode 1))

(use-package diff-hl
  :config (progn
            (global-diff-hl-mode)
            (diff-hl-flydiff-mode)
            (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)))

;;;; Language packages

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)))

(use-package js2-mode
  :mode (("\\.js\\'" . js2-mode)))

(use-package scss-mode
  :init (setq scss-compile-at-save nil)
  :mode (("\\.scss\\'" . scss-mode)))

(use-package yaml-mode)
(use-package markdown-mode)
(use-package elm-mode
  :config (add-to-list 'company-backends 'company-elm))
(use-package company-jedi
  :init (setq python-environment-directory "~/.virtualenvs/")
  :config (add-to-list 'company-backends 'company-jedi))
(use-package coffee-mode)
(use-package go-mode)
(use-package lua-mode)
(use-package virtualenvwrapper
  :init (setq venv-location "~/.virtualenvs/"))
(use-package haskell-mode)
