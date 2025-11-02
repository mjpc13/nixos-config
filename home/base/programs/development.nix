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
    ungoogled-chromium

    docker-compose
    lazydocker
    dive # explore docker layers
    sshfs
    zip
    unzip
    ghostty
    tmux
    fzf
    ripgrep
    tldr
    sshfs # Mount remote folders

    goose-cli #AI agent for coding

    # Languages
    (python311.withPackages (ps: with ps; [
      ipython
      pandas
      numpy
      pygobject3
      tkinter
    ]))
    
    clang
    gdb
    #rustup
    go
    nodejs
    julia
    #latex

    vscode
    surrealdb

    zotero
    texlive.combined.scheme-full
  ];

  programs = {

    command-not-found.enable = false;
    direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    zsh = {
      enable = false;
      # enableAutosuggestions = true;
      # enableCompletion = true;
      shellAliases = {
        update = "sudo nixos-rebuild --switch /home/mjpc13/Documents/nixos-config/";
      };
      # oh-my-zsh = {
      #   enable = true;
      #   plugins = [ "thefuck" ];
      #   theme = "robbyrussel";
      # };
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "mjpc13";
      userEmail = "mjpc13@protonmail.com";
      extraConfig = {
        core.editor = "nvim";
      };
    };

    vscode = {
      enable = true;
    };

  };

}
