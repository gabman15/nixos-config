(use-package php-mode
  :ensure t)
(use-package markdown-mode
  :ensure t)
(use-package nix-mode
  :ensure t)
(use-package json-mode
  :ensure t)
(use-package rust-mode
  :ensure t)

(use-package flycheck
  :ensure t)
(use-package lsp-mode
  :ensure t)
(use-package lsp-ui
  :ensure t)
(use-package company
  :ensure t)

(add-hook 'nix-mode-hook #'lsp)
(add-hook 'json-mode-hook #'lsp)
(add-hook 'php-mode-hook #'lsp)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'ruby-mode-hook #'lsp)

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "basedpyright")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(defun my-locate-python-virtualenv ()
  "Find the Python executable based on the VIRTUAL_ENV environment variable."
  (when-let ((venv (getenv "VIRTUAL_ENV")))
    (let ((python-path (expand-file-name "bin/python" venv)))
      (when (file-executable-p python-path)
        python-path))))

(with-eval-after-load 'lsp-pyright
  (add-to-list 'lsp-pyright-python-search-functions
               #'my-locate-python-virtualenv))

(setq lsp-enable-file-watchers nil)

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))
