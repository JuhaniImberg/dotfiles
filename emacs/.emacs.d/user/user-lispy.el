(el-get-bundle rainbow-delimiters)
(el-get-bundle paredit)

(defun lispy-mode ()
  (enable-paredit-mode)
  (rainbow-delimiters-mode))

(add-hook-multi (list 'emacs-lisp-mode-hook
                      'scheme-mode-hook)
                'lispy-mode)

(put 'describe 'scheme-indent-function 1)
(put 'it 'scheme-indent-function 1)

(provide 'user-lispy)
