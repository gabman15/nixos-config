(load-file "~/.emacs.d/packages.el")

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file) (load custom-file ))

(load-file "~/.emacs.d/theme.el")

;;font
(add-to-list 'default-frame-alist '(font . "Hack-12"))

(setq paren-mode t)
(setq column-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq inhibit-startup-screen t)
(setq vc-follow-symlinks t)
(tool-bar-mode -1)
(menu-bar-mode -1)
;;(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-display-line-numbers-mode)

;;org mode
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setq org-agenda-files '("~/org/notes.org"))

(setq org-capture-templates
      '(("n" "Notes" entry
         (file+headline "~/org/notes.org" "Notes")
         "* %^{Heading} %t")
        ("t" "Tasks" entry
         (file+headline "~/org/notes.org" "Tasks")
         "* %^{Heading} %^t")))
;;--------------------------------------------------------------------------------
(when (display-graphic-p)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)) 
;;--------------------------------------------------------------------------------

;; put backup files in a new place
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(put 'downcase-region 'disabled nil)

;;evil mode
;;(require 'evil)
;;(evil-mode 1)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;;
(add-hook 'tuareg-mode-hook (lambda ()
                              (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
                              (merlin-mode)))
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

;;lsp mode

(require 'lsp-mode)
(add-hook 'json-mode-hook #'lsp)
(add-hook 'php-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'ruby-mode-hook #'lsp)

(setq lsp-pyright-langserver-command "basedpyright")
(add-hook 'python-mode-hook (lambda () (require 'lsp-pyright) (lsp)))
(setq lsp-enable-file-watchers nil)
