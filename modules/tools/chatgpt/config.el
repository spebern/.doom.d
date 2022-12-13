;;; tools/chatgpt/config.el -*- lexical-binding: t; -*-

(use-package chatgpt
  :init
  (setq chatgpt-repo-path "~/.emacs.d/straight/repos/ChatGPT.el/")
  :bind ("C-c q" . chatgpt-query))
