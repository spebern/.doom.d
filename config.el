;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Bernhard Specht"
      user-mail-address "bernhard@specht.net"

      display-line-numbers-type nil)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 22))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; rust
(after! rustic
  (setq rustic-lsp-server 'rust-analyzer)
  (setq lsp-rust-analyzer-cargo-watch-command "clippy")
  (setq lsp-rust-analyzer-cargo-load-out-dirs-from-check t)
  (setq lsp-rust-analyzer-proc-macro-enable t)
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-parameter-hints t)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-all-features t)
  (setq lsp-rust-full-docs t)
  (setq lsp-enable-semantic-highlighting t))

;; python
(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

;; ivy
(setq ivy-read-action-function #'ivy-hydra-read-action)

;; evil
(setq evil-escape-unordered-key-sequence t)

;; perl
(add-hook! 'perl-mode-hook (format-all-code - 1))

;; email
(set-email-account! "specht.net"
  '((mu4e-sent-folder       . "/specht.net/Sent Mail")
    (mu4e-drafts-folder     . "/specht.net/Drafts")
    (mu4e-trash-folder      . "/specht.net/Trash")
    (mu4e-refile-folder     . "/specht.net/All Mail")
    (smtpmail-smtp-user     . "bernhard@specht.net")
    (user-mail-address      . "bernhard@specht.net")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nBernhard Specht"))
  t)

(load! "+bindings")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(smtpmail-smtp-server "mail.cluster-team.com")
 '(smtpmail-smtp-service 25))

;; journal
(setq org-journal-encrypt-journal t)
