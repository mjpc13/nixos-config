{ lib, ... }:

{
  imports = [
    ./base
    ./extra/artistic.nix
    ./gnome
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home =
    let
      name = "mjpc13";
    in
    {
      username = "${name}";
      homeDirectory = lib.mkForce "/home/${name}";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      stateVersion = "22.11";
    };
  
  #Wallpapers
  #dconf.settings."org/gnome/desktop/background".picture-uri = lib.mkForce "file:///home/mjpc13/.config/wallpapers/itsv.jpg";
  #dconf.settings."org/gnome/desktop/background".picture-uri-dark = lib.mkForce "file:///home/mjpc13/.config/wallpapers/itsv.jpg";

  # screensaver
  # dconf.settings."org/gnome/desktop/screensaver".picture-uri = lib.mkForce "file:///home/mjpc13/.config/wallpapers/nix-dracula.png";


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}