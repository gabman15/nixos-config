(setq user-init-file (or load-file-name (buffer-file-name)))
(setq nix-emacs-directory (file-name-directory user-init-file))

(load "theme.el")
(load "style.el")
(load "programming.el")
