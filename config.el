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
(setq doom-font (font-spec :family "Source Code Pro" :size 13))
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
(defvar my-mu4e-account-alist
  '(("bernhard@specht.net"
     (mu4e-sent-folder "/bernhard@specht.net/Sent")
     (mu4e-drafts-folder "/bernhard@specht.net/Drafts")
     (mu4e-trash-folder "/bernhard@specht.net/Trash")
     (user-mail-address "bernhard@specht.net")
     (smtpmail-default-smtp-server "mail.cluster-team.com")
     (smtpmail-local-domain "mail.cluster-team.com")
     (smtpmail-smtp-user "bernhard@specht.net")
     (smtpmail-smtp-server "mail.cluster-team.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 25))
    ("b.specht@ecentral.de"
     (mu4e-sent-folder "/b.specht@ecentral.de/Sent")
     (mu4e-drafts-folder "/b.specht@ecentral.de/Drafts")
     (mu4e-trash-folder "/b.specht@ecentral.de/Trash")
     (user-mail-address "b.specht@ecentral.de")
     (smtpmail-default-smtp-server "smtprelaypool.ispgateway.de")
     (smtpmail-local-domain "smtprelaypool.ispgateway.de")
     (smtpmail-smtp-user "b.specht@ecentral.de")
     (smtpmail-smtp-server "smtprelaypool.ispgateway.de")
     (smtpmail-stream-type ssl)
     (smtpmail-smtp-service 465))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

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

;; kubernetes
(use-package! kubernetes
  :commands (kubernetes-overview))

(use-package! kubernetes-evil
  :after kubernetes)

(use-package! k8s-mode
  :hook (k8s-mode . yas-minor-mode))

(use-package! kubel)

(evil-set-initial-state 'kubel-mode 'emacs)

;; gitlab
(use-package! gitlab-ci-mode)

(use-package! gitlab-ci-mode-flycheck
  :after flycheck gitlab-ci-mode
  :init
  (gitlab-ci-mode-flycheck-enable))

;; latex
(setq +latex-viewers '(zathura))
(setq latex-preview-pane-use-frame t)

;; vue
(add-hook 'vue-mode-local-vars-hook #'lsp!)

(use-package! vue-mode
  :ensure t)

(use-package! vue-html-mode
  :mode ("/\\.vue$"))

;; perl
(use-package! cperl-mode
  :mode ("/\\.pm$" "/\\.pl$" "/\\.t$"))

(eval-after-load "org"
  '(require 'ox-confluence nil t))
;; protobuf
(use-package! protobuf-mode)

;; org download (images etc)
(use-package! org-download)
(setq-default org-download-image-dir "~/Dropbox/org/images")

(setq-hook! 'vue-mode-hook +format-with-lsp nil)

;; jira export
(use-package! ox-jira)

;; org babel http
(use-package! ob-http)

(setq company-idle-delay 0.0)

 (setq wl-copy-process nil)
  (defun wl-copy (text)
        (setq wl-copy-process (make-process :name "wl-copy"
					                                            :buffer nil
										                                            :command '("wl-copy" "-f" "-n")
															                                            :connection-type 'pipe))
	    (process-send-string wl-copy-process text)
	        (process-send-eof wl-copy-process))
  (defun wl-paste ()
        (if (and wl-copy-process (process-live-p wl-copy-process))
	          nil ; should return nil if we're the current paste owner
		          (shell-command-to-string "wl-paste -n | tr -d \r")))
  (setq interprogram-cut-function 'wl-copy)
  (setq interprogram-paste-function 'wl-paste)
