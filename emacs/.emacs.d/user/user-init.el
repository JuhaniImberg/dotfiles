(require 'user-el-get)
(require 'user-theme)
(require 'user-keymap)

(el-get-bundle technomancy/better-defaults)
(el-get-bundle undo-tree
  (global-undo-tree-mode))
(el-get-bundle easy-kill
  (global-set-key [remap kill-ring-save] 'easy-kill))

(defun add-hook-multi (hooks fn)
  (mapc (lambda (hook)
          (add-hook hook fn))
        hooks))

(require 'user-lispy)

(el-get 'sync)
(provide 'user-init)
