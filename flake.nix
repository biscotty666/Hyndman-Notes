{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";

    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      #packageOverrides = pkgs.callPackage ./python-packages.nix {};
      #python3 = pkgs.python3.override { inherit packageOverrides; };
    in {
      devShell = pkgs.mkShell {
        name = "python-venv";
        venvDir = "./.venv";
        buildInputs = with pkgs; [
            R
            rPackages.pagedown
            rPackages.quarto
            rPackages.fpp3
            rPackages.tidyverse
            rPackages.latex2exp
            rPackages.GGally
            rPackages.seasonal
            chromium
            pandoc
            texlive.combined.scheme-full
            rstudio
            quarto
        ];

        shellHook = ''
            export BROWSER=zen
            #jupyter lab
        '';

      };
    }
  );
}
