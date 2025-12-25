;; Emacs Tree-sitter configuration for Luna-lang
;; Add this to your Emacs configuration

(use-package treesit
  :when (treesit-available-p)
  :config
  ;; Register Luna mode with tree-sitter
  (add-to-list 'treesit-language-source-alist
               '(luna "https://github.com/luna-lang/tree-sitter-luna"))
  
  ;; Auto-install the Luna grammar if needed
  (unless (treesit-language-available-p 'luna)
    (treesit-install-language-grammar 'luna)))

;; Define Luna major mode with tree-sitter support
(define-derived-mode luna-ts-mode prog-mode "Luna"
  "Major mode for Luna-lang with tree-sitter support."
  :syntax-table lisp-mode-syntax-table
  
  ;; Set up tree-sitter
  (when (treesit-ready-p 'luna)
    (treesit-parser-create 'luna)
    
    ;; Font-lock settings
    (setq-local treesit-font-lock-settings
                (treesit-font-lock-rules
                 :language 'luna
                 :feature 'comment
                 '((comment) @font-lock-comment-face)
                 
                 :language 'luna
                 :feature 'string
                 '((string) @font-lock-string-face)
                 
                 :language 'luna  
                 :feature 'number
                 '((number) @font-lock-constant-face)
                 
                 :language 'luna
                 :feature 'keyword
                 '((keyword) @font-lock-builtin-face)
                 
                 :language 'luna
                 :feature 'boolean
                 '((boolean) @font-lock-constant-face)
                 
                 :language 'luna
                 :feature 'definition
                 '((def_form name: (simple_symbol) @font-lock-function-name-face)
                   (defmacro_form name: (simple_symbol) @font-lock-function-name-face))
                 
                 :language 'luna
                 :feature 'special-form
                 '(["def" "fn" "if" "let" "quote" "defmacro" "ns"] @font-lock-keyword-face)))
    
    ;; Enable font-lock features
    (setq-local treesit-font-lock-feature-list
                '((comment string number keyword boolean)
                  (definition special-form)
                  ()))
    
    ;; Set up indentation
    (setq-local treesit-simple-indent-rules
                '((luna
                   ((node-is ")") parent-bol 0)
                   ((node-is "]") parent-bol 0)  
                   ((node-is "}") parent-bol 0)
                   ((parent-is "list") parent-bol 2)
                   ((parent-is "vector") parent-bol 2)
                   ((parent-is "map") parent-bol 2))))
    
    (treesit-major-mode-setup)))

;; Associate .luna files with luna-ts-mode
(add-to-list 'auto-mode-alist '("\\.luna\\'" . luna-ts-mode))

;; Optional: Set up additional Luna-specific features
(with-eval-after-load 'luna-ts-mode
  ;; Comment syntax
  (setq-local comment-start ";;")
  (setq-local comment-end "")
  (setq-local comment-start-skip ";+\\s-*")
  
  ;; Imenu support for navigation
  (setq-local imenu-generic-expression
              '(("Functions" "^\\s-*(def\\s-+\\(\\sw+\\)" 1)
                ("Macros" "^\\s-*(defmacro\\s-+\\(\\sw+\\)" 1)
                ("Namespaces" "^\\s-*(ns\\s-+\\(\\sw+\\)" 1))))

;; Optional: Add Luna REPL integration
(defun luna-eval-last-sexp ()
  "Evaluate the Luna expression before point."
  (interactive)
  ;; Implementation would depend on your Luna REPL setup
  (message "Luna eval not implemented yet"))

(defun luna-eval-buffer ()
  "Evaluate the entire Luna buffer."
  (interactive)
  ;; Implementation would depend on your Luna REPL setup  
  (message "Luna eval-buffer not implemented yet"))

;; Key bindings for Luna mode
(define-key luna-ts-mode-map (kbd "C-c C-e") 'luna-eval-last-sexp)
(define-key luna-ts-mode-map (kbd "C-c C-k") 'luna-eval-buffer)