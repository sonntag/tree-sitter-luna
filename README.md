# Tree-sitter Luna

[Tree-sitter](https://tree-sitter.github.io) grammar for [Luna-lang](https://github.com/yourusername/luna-lang), providing syntax highlighting, code folding, and structural editing support across many editors.

## Overview

This Tree-sitter grammar enables rich editor support for Luna-lang including:

- **Syntax Highlighting**: Accurate, scope-based highlighting for all Luna constructs
- **Code Folding**: Intelligent folding of lists, vectors, maps, and function definitions
- **Structural Navigation**: Move between functions, namespaces, and forms
- **Incremental Parsing**: Fast, error-tolerant parsing as you type
- **Multi-Editor Support**: Works with Neovim, Emacs, VS Code, GitHub, and more

## Quick Start

### Using devenv (recommended)

```bash
cd tree-sitter-luna
direnv allow   # or: devenv shell

# Run tests
test

# Parse a file
parse examples/sample.luna

# Highlight a file
highlight examples/sample.luna
```

### Using npm

```bash
cd tree-sitter-luna
npm install
npx tree-sitter generate
npx tree-sitter test
```

## Editor Integration

### Neovim (with nvim-treesitter)

1. Add the parser configuration to your Neovim config:

```lua
-- In your init.lua or after/plugin/luna.lua

-- Register the Luna filetype
vim.filetype.add({
  extension = {
    luna = 'luna',
  },
})

-- Register Luna parser with nvim-treesitter
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.luna = {
  install_info = {
    url = "https://github.com/yourusername/tree-sitter-luna",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "luna",
}
```

2. Install the parser: `:TSInstall luna`

3. Copy query files to nvim-treesitter:
```bash
mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/luna
cp /path/to/tree-sitter-luna/queries/*.scm ~/.local/share/nvim/lazy/nvim-treesitter/queries/luna/
```

See [`examples/neovim.lua`](examples/neovim.lua) for full configuration.

### Emacs (with tree-sitter support)

Add the configuration from [`examples/emacs.el`](examples/emacs.el) to your Emacs config.

### VS Code

A VS Code extension can be built using the configuration in [`examples/vscode.json`](examples/vscode.json).

## Grammar Features

### Supported Syntax

| Feature | Example |
|---------|---------|
| Numbers | `42`, `-17` |
| Strings | `"hello"`, `"with ${interpolation}"` |
| Keywords | `:keyword`, `:key-with-dashes` |
| Symbols | `foo`, `foo.bar`, `namespace/symbol` |
| Lists | `(func arg1 arg2)` |
| Vectors | `[1 2 3]` |
| Maps | `{:key "value"}` |
| Quote | `'expr` |
| Quasiquote | `` `(template ~unquote) `` |
| Unquote-splice | `~@list` |
| Comments | `;; comment` |

### Special Forms

The grammar recognizes Luna's special forms for proper highlighting:
- `def`, `defmacro`, `fn`, `if`, `let`, `do`
- `match`, `when`, `unless`, `cond`
- `and`, `or`, `quote`
- `ns`, `require`, `export`, `import`
- `deftype`, `deftag`

### Highlighting Scopes

```
@comment           - comments
@number            - numeric literals
@string            - string literals
@constant          - keywords (:foo)
@variable          - symbols
@keyword           - special forms (def, fn, if, etc.)
@function.builtin  - built-in functions (+, -, map, filter, etc.)
@function.call     - function calls
@punctuation.bracket  - brackets
@punctuation.special  - quote marks
@error             - parse errors
```

## Query Files

- **`queries/highlights.scm`**: Syntax highlighting rules
- **`queries/locals.scm`**: Scope-aware features (go-to-definition)
- **`queries/folds.scm`**: Code folding patterns
- **`queries/injections.scm`**: Language injection (markdown in docstrings)

## Development

### Modifying the Grammar

1. Edit `grammar.js`
2. Regenerate: `tree-sitter generate` (or `generate` in devenv)
3. Test: `tree-sitter test` (or `test` in devenv)
4. Try parsing: `tree-sitter parse your-file.luna`

### Adding Highlighting Rules

Edit `queries/highlights.scm` using Tree-sitter's query language.

## Project Structure

```
tree-sitter-luna/
├── grammar.js           # Main grammar definition
├── devenv.nix           # Development environment
├── src/
│   ├── parser.c         # Generated C parser
│   ├── grammar.json     # Generated grammar JSON
│   └── node-types.json  # Generated node types
├── queries/
│   ├── highlights.scm   # Syntax highlighting
│   ├── locals.scm       # Scope analysis
│   ├── folds.scm        # Code folding
│   └── injections.scm   # Language injection
├── test/corpus/         # Test cases
├── examples/            # Editor integration examples
├── package.json         # npm configuration
└── tree-sitter.json     # Tree-sitter metadata
```

## License

MIT
