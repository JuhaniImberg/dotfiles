(el-get-bundle company-anaconda
  (progn
    (add-to-list 'company-backends 'company-anaconda)
    (add-hook 'python-mode-hook 'eldoc-mode)
    (add-hook 'python-mode-hook 'anaconda-mode)))

(provide 'user-python)
