{ pkgs ? import <nixpkgs> { }, ... }:
let
  dependencies = with pkgs; [
    git
    curl
    gnused
  ];
  path = builtins.concatStringsSep ":" (map (pkg: "${pkg}/bin") dependencies);
  header = ''
    #!${pkgs.zsh}/bin/zsh

    # Add dependencies to PATH
    export PATH="${path}:$PATH"

    # -- nix header ends here --
  '';
  src = builtins.readFile ./build.zsh;
in
pkgs.writeTextFile {
  name = "updater";
  text = header + src;
  executable = true;
}
