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

    noisetorch #improve audio on calls
    gimp
    okular #PDF viewer
    vlc #video

    obsidian #Note taking
  ];

}
