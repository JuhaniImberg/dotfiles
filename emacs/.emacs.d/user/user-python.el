(el-get-bundle tkf/emacs-jedi
  :load ("jedi-core.el")
  :name jedi-core
  :depends (epc python-environment))

(el-get-bundle company-jedi
  :depends (company-mode)
  (add-hook 'python-mode-hook
            (lambda () (add-to-list 'company-backends 'company-jedi))))

(setq python-environment-directory "~/.virtualenvs/")

(provide 'user-python)
