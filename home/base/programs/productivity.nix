{ pkgs, pkgs-unstable, ... }:

{
  #############################################################
  #
  #  Basic settings for productivity
  # 
  #############################################################
  home.packages = with pkgs; [

    slack
    thunderbird
    spotify

    gimp
    kdePackages.okular #PDF viewer
    libreoffice-qt #Office Suite
    vlc #video

    obsidian #Note taking
  ];

}
