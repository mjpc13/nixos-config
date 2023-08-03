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
    ripgrep

    # DO NOT install build tools for C/C++, set it per project by devShell instead
    gnumake # used by this repo, to simplify the deployment

    # Languages
    (python311.withPackages (ps: with ps; [
      ipython
      pandas
      numpy
      pygobject3
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

    zsh = {
      enable = true;
      enableCompletion = true; # enabled in oh-my-zsh
      shellAliases = {
        edit = "fzf | xargs -I {} kitty -e nvim " { } " ";
      };

    };

    # git = {
    #   enable = true;
    #   package = pkgs.gitAndTools.gitFull;
    #   userName = "Mario Cristovao";
    #   userEmail = "mjpc13@protonmail.com";
    #   extraConfig = {
    #     core.editor = "nvim";
    #   };
    # };

  };
}
