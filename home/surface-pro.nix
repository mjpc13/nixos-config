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

  gnome.wallpaper-dark = lib.mkDefault "file:///home/mjpc13/.config/wallpapers/spooky_spil.jpg";

  gnome.favorite-apps = [
    "firefox.desktop"
    "slack.desktop"
    "org.gnome.Nautilus.desktop"
    "com.github.xournalpp.xournalpp.desktop"
  ];




  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

