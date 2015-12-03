(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/user")

(require 'user-init)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
