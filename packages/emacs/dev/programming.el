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
(add-hook 'nxml-mode-hook #'lsp)

(add-to-list 'auto-mode-alist '("\\.xaml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.axaml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.dashboard\\'" . json-mode))

(lsp-register-client (make-lsp-client
                      :new-connection (lsp-stdio-connection "lemminx")
                      :activation-fn (lsp-activate-on "xml")
                      :server-id 'lemminx))

(use-package ccls
  :ensure t
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "basedpyright")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package dap-mode
  :ensure t
  :bind*
  (("<f5>" . dap-next)
   ("<f6>" . dap-step-in)))
(require 'dap-python)
(setopt dap-auto-configure-mode t)
(setq dap-python-debugger 'debugpy)
(setq dap-ui-variable-length 200)

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
