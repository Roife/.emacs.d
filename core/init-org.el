;;; -*- lexical-binding: t -*-

;; [org-fragtog] Preview and edit latex in md/org
(use-package org-fragtog
  :straight t
  :hook ((org-mode . org-fragtog-mode))
  )

;; [org]
(use-package org
  :custom-face
  (org-quote ((t (:inherit org-block-begin-line))))

  :config
  ;; 让中文也可以不加空格就使用行内格式
  (setq org-emphasis-regexp-components '("-[:space:]('\"{[:nonascii:]"
                                         "-[:space:].,:!?;'\")}\\[[:nonascii:]"
                                         "[:space:]"
                                         "."
                                         1))
  (org-set-emph-re 'org-emphasis-regexp-components org-emphasis-regexp-components)
  (org-element-update-syntax)

  ;; 规定上下标必须加 {}，否则中文使用下划线时它会以为是两个连着的下标
  (setq org-use-sub-superscripts "{}")

  (setq org-fontify-quote-and-verse-blocks t)

  (defun org-custom-link-img-follow (path)
    (org-open-file
     (format "%s/%s" (project-root (project-current)) path)))

  (defun org-custom-link-img-export (path desc format)
    (cond
     ((eq format 'html)
      (format "<img src=\"/images/%s\" alt=\"%s\"/>" path desc))))

  (org-link-set-parameters "img" :follow 'org-custom-link-img-follow :export 'org-custom-link-img-export)

  ;; Org Latex Preview
  (setq org-latex-create-formula-image-program 'dvisvgm
        org-startup-with-latex-preview nil)
  (plist-put org-format-latex-options :scale 1.5)

  (setq org-support-shift-select t)
  )


;; [org-indent]
(use-package org-indent
  :after org
  :hook (org-mode . org-indent-mode))


;; [ox]
(use-package ox
  :config
  (setq org-export-with-smart-quotes t
        org-html-validation-link nil
        org-latex-prefer-user-labels t
        org-export-with-latex t))

;; [ox-hugo]
(use-package ox-hugo
  :straight t
  :after ox
  :init (require 'ox-hugo)
  :config
  (setq org-hugo-default-section-directory "posts"
        org-hugo-base-dir +blog-dir
        org-hugo-external-file-extensions-allowed-for-copying nil)
  )
