(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq package-list '(yaml-mode auctex company lsp-ui exec-path-from-shell lsp-mode lsp-pyright yafolding php-mode yaml-mode json-mode tuareg ini-mode which-key ement sml-mode auto-complete-auctex all-the-icons-dired all-the-icons arduino-cli-mode arduino-mode markdown-mode rust-mode gnu-elpa-keyring-update autothemer exec-path-from-shell nix-mode))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
