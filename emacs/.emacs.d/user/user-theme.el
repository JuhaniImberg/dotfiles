(el-get-bundle moe-theme
  (progn
    (custom-set-variables
     '(custom-safe-themes
       (quote
        ("3625c04fa4b8a802e96922d2db3f48c9cb2f93526e1dc24ba0b400e4ee4ccd8a"
         "74278d14b7d5cf691c4d846a4bbf6e62d32104986f104c1e61f718f9669ec04b"
         default))))

    (load-theme 'moe-dark t)))

(provide 'user-theme)
