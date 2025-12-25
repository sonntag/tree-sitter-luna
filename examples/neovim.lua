-- Neovim Tree-sitter configuration for Luna-lang
-- Add this to your Neovim configuration (e.g., ~/.config/nvim/after/plugin/luna.lua)

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
    -- Use git URL for the grammar
    url = "https://github.com/yourusername/tree-sitter-luna",
    -- Or use a local path during development:
    -- url = "~/path/to/tree-sitter-luna",
    files = { "src/parser.c" },
    branch = "main",
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "luna",
}

-- Configure tree-sitter
require'nvim-treesitter.configs'.setup {
  -- Enable syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- Enable incremental selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  -- Enable indentation
  indent = {
    enable = true
  },
}

-- Set up Luna-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "luna",
  callback = function()
    -- Set comment string for Luna
    vim.bo.commentstring = ";; %s"

    -- Set up indentation (Lisp-style)
    vim.bo.lisp = true
    vim.bo.autoindent = true
    vim.bo.smartindent = true

    -- Enable folding based on tree-sitter
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    vim.wo.foldenable = false -- Start with folds open
  end,
})

-- After running :TSInstall luna, copy query files to nvim-treesitter:
--
-- For lazy.nvim:
--   mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/luna
--   cp /path/to/tree-sitter-luna/queries/*.scm \
--      ~/.local/share/nvim/lazy/nvim-treesitter/queries/luna/
--
-- For packer.nvim:
--   mkdir -p ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/queries/luna
--   cp /path/to/tree-sitter-luna/queries/*.scm \
--      ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/queries/luna/

-- Optional: Add Luna-specific keybindings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "luna",
  callback = function()
    local opts = { buffer = true, silent = true }

    -- Evaluate current form (if you have a Luna REPL integration)
    vim.keymap.set("n", "<leader>ee", "<cmd>LunaEvalForm<cr>", opts)

    -- Evaluate entire file
    vim.keymap.set("n", "<leader>ef", "<cmd>LunaEvalFile<cr>", opts)
  end,
})
