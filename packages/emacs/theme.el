(use-package autothemer
             :ensure t)

(add-to-list 'custom-theme-load-path (concat nix-emacs-directory "/themes"))
(setq custom-safe-themes t) ; Treat all themes as safe
(load-theme 'gruvbox-dark-hard)
