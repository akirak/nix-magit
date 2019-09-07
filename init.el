;; Configure package.el to use packages installed by Nix
(require 'package)
(setq package-archives nil)
(package-initialize)

;; Set up theme
(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-night t)

;; Start magit-status
(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
(magit-status)
