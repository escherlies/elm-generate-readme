{
  description = "elm-generate-readme - Generate a README.md from an Elm file";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        haskellPackages = pkgs.haskell.packages.ghc92;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with haskellPackages; [
            # Haskell toolchain
            ghc
            cabal-install

            # Haskell Language Server for IDE support
            haskell-language-server

            # Formatter (from fourmolu.yaml)
            fourmolu

            # Development tools
            pkgs.ghcid
          ];

          shellHook = ''
            echo "elm-generate-readme development environment"
            echo "GHC version: $(ghc --version)"
            echo "Cabal version: $(cabal --version | head -n 1)"
            echo ""
            echo "Available commands:"
            echo "  cabal build        - Build the project"
            echo "  cabal install      - Install the executable"
            echo "  cabal repl         - Start a REPL"
            echo "  fourmolu -i app/   - Format code"
            echo "  ghcid              - Run ghcid for rapid feedback"
          '';
        };
      }
    );
}
