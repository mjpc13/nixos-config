{ pkgs, pkgs-unstable, ... }:

{
  #############################################################
  #
  #  Basic settings for development environment
  # 
  #############################################################

  home.packages = with pkgs; [
    #pkgs-unstable.devbox

    #Web stuff
    firefox

    docker-compose
    lazydocker
    dive # explore docker layers
    sshfs
    zip
    unzip
    kitty
    fzf

    # DO NOT install build tools for C/C++, set it per project by devShell instead
    gnumake # used by this repo, to simplify the deployment

    # Languages
    (python311.withPackages (ps: with ps; [
      ipython
      pandas
      numpy
    ]))

    # gcc
    gdb
    rustup
    go
    nodejs
    julia
    #latex
    texlive.combined.scheme-full

  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
