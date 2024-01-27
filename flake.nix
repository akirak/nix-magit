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
    packages = eachSystem (pkgs: {
      default = pkgs.writeShellApplication {
        name = "emacs-with-magit";
        runtimeInputs = [
          (pkgs.emacs.pkgs.withPackages (epkg: [
            epkg.magit
            epkg.color-theme-sanityinc-tomorrow
          ]))
        ];
        text = ''
          if ! git rev-parse --quiet --show-toplevel; then
            exit 1
          fi
          emacs -nw -Q -l ${./init.el}
          exit
        '';
      };
    });
  };
}
