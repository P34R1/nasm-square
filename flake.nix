{
  description = "An empty flake template that you can adapt to your own environment";

  # Flake inputs
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  # Flake outputs
  outputs =
    { self, nixpkgs }:
    let
      # The systems supported for this flake
      supportedSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                (final: prev: {
                  asm-lsp = prev.asm-lsp.overrideAttrs (oldAttrs: rec {
                    version = "master";

                    src = prev.fetchFromGitHub {
                      owner = "bergercookie";
                      repo = "asm-lsp";
                      rev = "master";
                      hash = "sha256-08BNqQX60StKtC2rF5tlnhiBR6niE6t4Mk3H7dUFFDg=";
                    };

                    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
                      prev.lib.const {
                        inherit src;
                        outputHash = "sha256-SxXxA8I27xG+7cDhU3KpXbsLvv6ls+YsFuq4mg3J46A=";
                      }
                    );
                  });
                })
              ];
            };
          }
        );
    in
    {
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
            # The Nix packages provided in the environment
            # Add any you need here
            packages = with pkgs; [
              nasm
              nasmfmt
              asm-lsp
              clang-tools

              ed # The standard
            ];

            # Set any environment variables for your dev shell
            env = { };

            # Add any shell logic you want executed any time the environment is activated
            shellHook = '''';
          };
        }
      );
    };
}
