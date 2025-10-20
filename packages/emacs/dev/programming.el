;; (load "lsp-java.el")
;; (load "dap-java.el")
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


(use-package lsp-java
  :ensure t)
;; (add-hook 'java-mode-hook #'lsp)

;; (setq lsp-java-jdt-ls-prefer-native-command t)
;; (setq lsp-java-server-install-dir (f-dirname (f-dirname (executable-find lsp-java-jdt-ls-command))))



;; (use-package ccls
;;   :ensure t
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp))))

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "basedpyright")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package dap-mode
  :ensure t
  :bind*
  (("<f5>" . dap-step-in)
   ("<f6>" . dap-next)
   ("<f7>" . dap-step-out)
   ("<f8>" . dap-continue)
   ("<f9>" . dap-breakpoint-toggle)))
(setopt dap-auto-configure-mode t)
(setq dap-ui-variable-length 200)

(require 'dap-python)
(setq dap-python-debugger 'debugpy)
;; (require 'dap-java)

;; (dap-register-debug-provider
;;  "java"
;;  (lambda (conf)
;;    (plist-put conf :debugPort 9000)
;;    (plist-put conf :host "localhost")
;;    (plist-put conf :debugServer (with-lsp-workspace (lsp-find-workspace 'jdtls)
;;                                  (lsp-send-execute-command "vscode.java.startDebugSession")))
;;    conf))

;; (dap-register-debug-template
;;   "Java Attach"
;;   (list :name "Java Attach"
;;         :type "java"
;;         :request "attach"
;;         :hostName "localhost"
;;         :port 9000))

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
