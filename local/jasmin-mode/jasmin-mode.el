(defvar jasmin-font-lock-keywords
  `((,(concat "\\_<"
              (regexp-opt '("u8"
                            "u16"
                            "u32"
                            "u64"
                            "u128"
                            "u256"
                            "8u"
                            "16u"
                            "32u"
                            "64u"
                            "128u"
                            "256u"
                            "bool"
                            "int"
                            "align"
                            "const"
                            "downto"
                            "else"
                            "exec"
                            "false"
                            "fn"
                            "for"
                            "from"
                            "global"
                            "if"
                            "inline"
                            "mut"
                            "namespace"
                            "param"
                            "ptr"
                            "reg"
                            "require"
                            "return"
                            "repeat"
                            "stack"
                            "to"
                            "true"
                            "while"
                            "export"))
              "\\_>")
     (0 font-lock-keyword-face))))

(define-derived-mode jasmin-mode c-mode "Jasmin"
  "Jasmin major mode."
  (set (make-local-variable 'indent-tabs-mode) nil)
  (set (make-local-variable 'c-basic-offset) 4)
  (set (make-local-variable 'font-lock-defaults) '(jasmin-font-lock-keywords)))

(provide 'jasmin-mode)

(add-to-list 'auto-mode-alist '("\\.jazz\\'" . jasmin-mode))
(add-to-list 'auto-mode-alist '("\\.jinc\\'" . jasmin-mode))
(add-to-list 'auto-mode-alist '("\\.japp\\'" . jasmin-mode))
