;; Tree-sitter locals queries for Luna-lang
;; These queries help with scope-aware features like "go to definition"

;; Lists create scopes for function calls
(list) @local.scope

;; References (symbols that might refer to definitions)
(symbol) @local.reference
