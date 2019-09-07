;; Configure package.el to use packages installed by Nix
(require 'package)
(setq package-archives nil)
(package-initialize)

;; Set up theme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)

;; Disable all local variables
(setq enable-local-variables nil)

;; Use ivy for completion
(ivy-mode 1)

;; Start magit-status
(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
(magit-status)
(local-set-key "q" #'kill-emacs)
