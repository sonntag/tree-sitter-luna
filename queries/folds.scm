;; Tree-sitter folding queries for Luna-lang

;; Fold lists, vectors, and maps
(list) @fold
(vector) @fold
(map) @fold

;; Fold multi-line comments
((comment) @fold
  (#match? @fold "\n"))
