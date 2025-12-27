;; Tree-sitter injection queries for Luna-lang

;; Comments that look like documentation
((comment) @injection.content
  (#match? @injection.content "^;; ")
  (#set! injection.language "markdown"))

;; String literals that might contain other languages
;; (This is a basic example - could be extended for SQL, HTML, etc.)
((string) @injection.content
  (#match? @injection.content "^\"(SELECT|INSERT|UPDATE|DELETE)")
  (#set! injection.language "sql"))
