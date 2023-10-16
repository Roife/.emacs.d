(use-package telega
  :straight t
  :hook ((telega-chat-mode . visual-line-mode))
  :bind (:map telega-chat-button-map
              ("h" . nil))
  :config
  (setq telega-chat-show-avatars nil
        telega-user-show-avatars nil
        telega-root-show-avatars nil
        telega-chat-fill-column 58
        telega-translate-to-language-by-default "zh"
        telega-chat-input-markups '(nil "org")
        telega-chat-prompt-format "▶ "
        telega-completing-read-function completing-read-function)

  (if (eq system-type 'darwin)
      (setq telega-proxies '((:server "127.0.0.1" :port 7890 :enable t :type (:@type "proxyTypeSocks5"))))
    (setq telega-server-libs-prefix "/usr"
          telega-proxies '((:server "127.0.0.1" :port 7891 :enable t :type (:@type "proxyTypeSocks5")))))
  )
