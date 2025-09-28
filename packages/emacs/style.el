;; font
(add-to-list 'default-frame-alist '(font . "Hack-12"))

;; aesthetic
(setq paren-mode t)
(setq column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode)
(put 'downcase-region 'disabled nil)

;; All the icons

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :if (display-graphic-p))

(when (display-graphic-p)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

;; put backup files in a new place
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)
