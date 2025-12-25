{
  config,
  pkgs,
  ...
}: {
  # Tree-sitter Luna Grammar Development Environment

  packages = with pkgs; [
    tree-sitter
    gcc # For compiling the parser
    claude-code
  ];

  languages.javascript = {
    enable = true;
    bun.enable = true;
  };

  languages.python.enable = true;

  # processes = {
  #   treesitter-watch = {
  #     exec = "cd luna-treesitter && tree-sitter generate --watch";
  #     process-compose = {
  #       availability.restart = "on_failure";
  #     };
  #   };
  # };

  claude.code = {
    enable = true;
    mcpServers = {
      # Local devenv MCP server
      devenv = {
        type = "stdio";
        command = "devenv";
        args = ["mcp"];
        env = {
          DEVENV_ROOT = config.devenv.root;
        };
      };
    };
  };

  scripts = {
    generate.exec = ''
      tree-sitter generate
    '';

    test.exec = ''
      tree-sitter test
    '';

    parse.exec = ''
      tree-sitter parse "$@"
    '';

    highlight.exec = ''
      tree-sitter highlight "$@"
    '';

    build.exec = ''
      bun run generate && echo "Parser generated successfully"
    '';
  };

  enterShell = ''
    echo "🌙 Tree-sitter Luna development environment"
    echo ""
    echo "Available commands:"
    echo "  generate  - Generate parser from grammar.js"
    echo "  test      - Run grammar tests"
    echo "  parse     - Parse a .luna file"
    echo "  highlight - Highlight a .luna file"
    echo "  build     - Generate parser via bun"
    echo ""
  '';
}
