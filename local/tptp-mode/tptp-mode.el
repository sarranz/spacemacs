;;; tptp-mode.el --- Simple TPTP syntax highlighting -*- lexical-binding: t; -*-

;; Minimal major mode for TPTP (Thousands of Problems for Theorem Provers)
;; highlighting. Derives from prog-mode and highlights:
;;  - language keywords: thf, tff, fof, cnf, tcf, tpi, include
;;  - roles: axiom, hypothesis, definition, assumption, lemma, theorem, ...
;;  - defined/system symbols: $foo, $$bar
;;  - logical connectives/operators: !, ?, ~, &, |, <=>, =>, <=, <~>, ~|, ~&, !>, ?*, @+, @-, -->, :=, ==
;;
;; This mode is intentionally simple: only syntax highlighting.

;;; Code:

(defgroup tptp nil
  "Simple TPTP major mode."
  :group 'languages)

;; -----------------------------------------------------------------------------
;; Syntax table: comments and quoted tokens

(defvar tptp-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; Line comments start with % and go to end of line
    (modify-syntax-entry ?% "<" st)
    (modify-syntax-entry ?\n ">" st)
    ;; C-style block comments: /* ... */
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?* ". 23"   st)
    (modify-syntax-entry ?/ ". 14"   st)
    ;; Single-quoted atoms and double-quoted distinct objects as strings
    (modify-syntax-entry ?' "\"" st)
    (modify-syntax-entry ?\" "\"" st)
    ;; Back-quoted “variables” (as per BNF) – treat as word prefix
    (modify-syntax-entry ?` "'" st)
    st)
  "Syntax table for `tptp-mode'.")

;; -----------------------------------------------------------------------------
;; Font-lock (syntax highlighting)

(defconst tptp--language-keywords
  '("thf" "tff" "fof" "cnf" "tcf" "tpi" "include")
  "TPTP top-level language keywords.")

(defconst tptp--roles
  '("axiom" "hypothesis" "definition" "assumption" "lemma" "theorem"
    "corollary" "conjecture" "negated_conjecture" "plain" "type"
    "interpretation" "logic" "unknown" "fi_domain" "fi_functors" "fi_predicates")
  "TPTP formula roles.")

(defconst tptp--operators
  ;; Logical and structural connectives/operators appearing in TPTP
  '("!>" "?*" "@+" "@-" "!" "?" "~" "&" "|" "<=>" "=>" "<=" "<~>" "~|" "~&"
    "-->" ":=" "==" "=" "!=")
  "TPTP operators and connectives to highlight.")

(defconst tptp-font-lock-keywords
  `(
    ;; Language keywords
    (,(concat "\\_<" (regexp-opt tptp--language-keywords) "\\_>")
     . font-lock-keyword-face)

    ;; Roles
    (,(concat "\\_<" (regexp-opt tptp--roles) "\\_>")
     . font-lock-keyword-face)

    ;; Defined and system symbols: $foo, $$bar
    ("\\$\\$?\$?:[A-Za-z_][A-Za-z0-9_]*\$" . font-lock-builtin-face)

    ;; Operators/connectives (no word boundaries; they are punctuation)
    (,(regexp-opt tptp--operators) . font-lock-builtin-face)

    ;; Variables: uppercase identifiers (simple heuristic)
    ("\\<[A-Z][A-Za-z0-9_]*\\>" . font-lock-variable-name-face)
    )
  "Font-lock keywords for `tptp-mode'.")

;; -----------------------------------------------------------------------------
;; Major mode definition

;;;###autoload
(define-derived-mode tptp-mode prog-mode "TPTP"
  "Major mode for TPTP syntax highlighting (simple).
Only highlights keywords, roles, $-symbols, operators, and variables."
  :syntax-table tptp-mode-syntax-table
  (setq-local font-lock-defaults '(tptp-font-lock-keywords))
  (setq-local comment-start "%")
  (setq-local comment-end "")
  (setq-local comment-use-syntax t))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.p\\'" . tptp-mode))
;;;###autoload
(add-to-list 'auto-mode-alist '("\\.tptp\\'" . tptp-mode))

(provide 'tptp-mode)

;;; tptp-mode.el ends here
