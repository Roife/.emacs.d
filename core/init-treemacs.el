;;; init-treemacs.el --- Initialize treemacs.         -*- lexical-binding: t; -*-

;; Copyright (C) 2019  roife

;; Author: roife <roife@outlook.com>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Initialize treemacs.

;;; Code:
(eval-when-compile (require 'init-define))

;;;; Default: [treemacs]
(use-package treemacs
  :defines winum-keymap
  :commands (treemacs-follow-mode
             treemacs-filewatch-mode
             treemacs-fringe-indicator-mode
             treemacs-git-mode)
  :bind (("s-`"       . treemacs)
         ("M-0"       . treemacs-select-window)
         ("C-x 1"     . treemacs-delete-other-windows)
         ("C-x t t"   . treemacs)
         ("C-x t b"   . treemacs-bookmark)
         ("C-x t C-t" . treemacs-find-file)
         ("C-x t M-t" . treemacs-find-tag)
         :map treemacs-mode-map
         ([mouse-1]   . treemacs-single-click-expand-action))
  :init
  (with-eval-after-load 'winum
    (bind-key (kbd "M-9") #'treemacs-select-window winum-keymap))
  :config
  (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
        treemacs-file-event-delay           5000
        treemacs-follow-after-init          t
        treemacs-follow-recenter-distance   0.1
        treemacs-goto-tag-strategy          'refetch-index
        treemacs-indentation                2
        treemacs-indentation-string         " "
        treemacs-is-never-other-window      nil
        treemacs-no-png-images              nil
        treemacs-recenter-after-file-follow nil
        treemacs-recenter-after-tag-follow  nil
        treemacs-show-hidden-files          t
        treemacs-silent-filewatch           t
        treemacs-silent-refresh             t
        treemacs-sorting                    'alphabetic-desc
        treemacs-tag-follow-cleanup         t
        treemacs-tag-follow-delay           1.5
        treemacs-width                      30
        treemacs-no-png-images              t
        )

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python3"))))
    (`(t . t)
     (treemacs-git-mode 'extended))
    (`(t . _)
     (treemacs-git-mode 'simple)))

  (if (fboundp 'define-fringe-bitmap)
      (define-fringe-bitmap 'treemacs--fringe-indicator-bitmap
        (vector #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111
                #b00011111111)))

  (add-hook 'treemacs-mode-hook #'(lambda ()
                                    (setq line-spacing 3)))
  )

;;;; Supprt projectile: [treemacs-projectile]
(use-package treemacs-projectile
  :after projectile
  :bind (([M-f8] . treemacs-projectile)
         :map projectile-command-map
         ("h" . treemacs-projectile)))

(provide 'init-treemacs)
;;; init-treemacs.el ends here
