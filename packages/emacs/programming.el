(use-package markdown-mode
             :ensure t)
(use-package nix-mode
             :ensure t)
(use-package lsp-mode
             :ensure t)

(add-hook 'nix-mode-hook #'lsp)
