(require 'user-el-get)
(require 'user-theme)
(require 'user-keymap)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-auto-revert-mode 1)

(el-get-bundle technomancy/better-defaults)
(el-get-bundle undo-tree
  (global-undo-tree-mode))
(el-get-bundle easy-kill
  (global-set-key [remap kill-ring-save] 'easy-kill))
(el-get-bundle company-mode
  (global-company-mode))
(el-get-bundle yaml-mode
  (add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode)))

(defun add-hook-multi (hooks fn)
  (mapc (lambda (hook)
          (add-hook hook fn))
        hooks))

(require 'user-lispy)
(require 'user-python)

(el-get 'sync)
(provide 'user-init)
