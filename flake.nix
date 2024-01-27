{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs = {
    systems,
    nixpkgs,
    ...
  } @ inputs: let
    eachSystem = f:
      nixpkgs.lib.genAttrs (import systems) (
        system:
          f nixpkgs.legacyPackages.${system}
      );
  in {
    packages = eachSystem (pkgs: let
      emacs-with-magit = pkgs.emacs.pkgs.withPackages (epkg: [
        epkg.magit
        epkg.color-theme-sanityinc-tomorrow
      ]);

      emacs-with-evil-magit = pkgs.emacs.pkgs.withPackages (epkg: [
        epkg.magit
        epkg.evil
        epkg.evil-collection
        epkg.color-theme-sanityinc-tomorrow
      ]);
    in {
      default = pkgs.writeShellApplication {
        name = "emacs-with-magit";
        runtimeInputs = [
          emacs-with-magit
        ];
        text = ''
          if ! git rev-parse --quiet --show-toplevel; then
            exit 1
          fi
          emacs -nw -Q -l ${./init.el} -f magit-status
          exit
        '';
      };

      evil = pkgs.writeShellApplication {
        name = "emacs-with-evil-magit";
        runtimeInputs = [
          emacs-with-evil-magit
        ];
        text = ''
          if ! git rev-parse --quiet --show-toplevel; then
            exit 1
          fi
          emacs -nw -Q -l ${./init.el} -l ${./evil.el} -f magit-status
          exit
        '';
      };
    });
  };
}
