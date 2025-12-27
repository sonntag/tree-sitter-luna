;; Tree-sitter highlighting queries for Luna-lang

;; Comments
(comment) @comment

;; Literals
(number) @number
(string) @string

;; String interpolation
(string_interpolation) @embedded
(string_expression) @embedded

;; Keywords
(keyword) @constant

;; Symbols and identifiers
(symbol) @variable

;; Quote-related syntax
(quote) @punctuation.special
(quasiquote) @punctuation.special
(unquote) @punctuation.special
(unquote_splice) @punctuation.special

;; Special forms - must come before generic function call
((list
  .
  (symbol) @keyword)
  (#match? @keyword "^(def|defmacro|fn|if|let|do|match|when|unless|cond|and|or|quote|deftype|deftag|ns|require|export|import)$"))

;; Built-in functions (common ones)
((symbol) @function.builtin
  (#match? @function.builtin "^(\\+|\\-|\\*|/|[=<>]|[<][=]|[>][=]|not[=]|not|println|print|str|count|first|rest|cons|conj|get|assoc|dissoc|keys|vals|map|filter|reduce|apply|some|every\\?|concat|reverse|take|drop|nth|empty\\?)$"))

;; Type predicates
((symbol) @function.builtin
  (#match? @function.builtin "^(type\\?|subtype\\?|integer\\?|string\\?|keyword\\?|boolean\\?|list\\?|vector\\?|map\\?|function\\?|nil\\?)$"))

;; Delimiters
[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

;; Quote marks
"'" @punctuation.special
"`" @punctuation.special
"~" @punctuation.special
"~@" @punctuation.special

;; Function calls (first symbol in list) - only if not a keyword
(list
  .
  (symbol) @function.call)

;; Strings with escape sequences
(string
  "\"" @string.delimiter)

;; Error highlighting for incomplete forms
(ERROR) @error
