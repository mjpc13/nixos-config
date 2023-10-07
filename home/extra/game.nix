{ lib, pkgs, ... }:

###########################################################
#
# Steam Configuration
#
###########################################################
{
  home.packages = with pkgs; [

    wineWowPackages.stable

  lutris
  steam];
# programs.steam = {
#   enable = true;
#   remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
#   dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
# };
}
