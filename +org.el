;;; +org.el -*- lexical-binding: t; -*-

(setq! citar-bibliography '("~/Nextcloud/references.bib"))

(setq bookmark-default-file "~/Nextcloud/bookmarks")

(setq org-journal-encrypt-journal t)
(setq org-journal-dir "~/Nextcloud/org")

(use-package! ob-http)

(setq org-image-actual-width (list 550))

(setq-default org-download-image-dir "~/Nextcloud/org/images")
(setq-default org-roam-directory "~/Nextcloud/org")
(setq org-directory "~/Nextcloud/org/")

(use-package! org-modern
  :hook (org-mode . global-org-modern-mode)
  :config
  (setq org-modern-label-border 0.3))

(setq org-roam-capture-templates
      '(("m" "main" plain
         "%?"
         :if-new (file+head "main/${slug}.org"
                            "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "reference" plain "%?"
         :if-new
         (file+head "reference/${title}.org" "#+title: ${title}\n")
         :immediate-finish t
         :unnarrowed t)
        ("a" "article" plain "%?"
         :if-new
         (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
         :immediate-finish t
         :unnarrowed t)))

(defun bold/tag-new-node-as-draft ()
  (org-roam-tag-add '("draft")))
(add-hook 'org-roam-capture-new-node-hook #'bold/tag-new-node-as-draft)

(after! org
  (add-to-list 'org-capture-templates
               '("s" "Slipbox" entry  (file "braindump/org/inbox.org")
                 "* %?\n"))
  (add-to-list 'org-cite-global-bibliography "~/Nextcloud/references.bib"))
