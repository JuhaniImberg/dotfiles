(el-get-bundle rainbow-delimiters)
(el-get-bundle paredit)

(defun lispy-mode ()
  (enable-paredit-mode)
  (rainbow-delimiters-mode))

(add-hook-multi (list 'emacs-lisp-mode-hook
                      'scheme-mode-hook)
                'lispy-mode)

;; from http://wiki.call-cc.org/emacs

(defun scheme-module-indent (state indent-point normal-indent) 0)
(put 'module 'scheme-indent-function 'scheme-module-indent)

(put 'and-let* 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'handle-exceptions 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'match 'scheme-indent-function 1)

;; http://wiki.call-cc.org/eggref/4/missbehave uses these

(put 'describe 'scheme-indent-function 1)
(put 'it 'scheme-indent-function 1)

(provide 'user-lispy)
