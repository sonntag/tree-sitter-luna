{
  description = "Tree-sitter grammar for Luna-lang";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      grammar = pkgs.tree-sitter.buildGrammar {
        language = "luna";
        version = "0.1.0";
        src = ./.;
      };
    in {
      packages = {
        default = grammar;
        tree-sitter-luna = grammar;
      };
    });
}
