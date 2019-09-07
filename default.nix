{ pkgs ? import <nixpkgs> {} }:
let
  emacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesNgGen emacs).emacsWithPackages;
  emacsWithMagit = emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    magit
    evil
    evil-magit
    color-theme-sanityinc-tomorrow
  ]));
in
pkgs.mkShell {
  buildInputs = [emacsWithMagit pkgs.git];
  shellHook = ''
emacs -nw -Q -l ${./init.el}
exit
  '';
}
