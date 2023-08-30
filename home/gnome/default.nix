{ pkgs, ... }:

{
  # ...
  gtk = {
    enable = true;

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "WhiteSur";
      package = pkgs.whitesur-gtk-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "WhiteSur";
  # ...

  dconf.settings = {
    # To know what options you have, Run:
    # $ dconf watch /
    # Then go to preferences and edit the different settings


    "org/gnome/shell" = {

      disable-user-extensions = false;

      #For gnome extensions
      enabled-extensions = [

        # "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
      ];

      favorite-apps = [
        "firefox.desktop"
    #    "code.desktop"
    #    "org.gnome.Terminal.desktop"
    #    "spotify.desktop"
    #    "virt-manager.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/mutter".edge-tiling = true;
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
    };
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/y3crcz5chwxxf8na6lbsb36c92929mw4-simple-blue-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
      picture-uri-dark = "file:///nix/store/w55is6y280mc7p4h08k4aji60pys6gn0-simple-dark-gray-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-dark-gray.png";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///nix/store/y3crcz5chwxxf8na6lbsb36c92929mw4-simple-blue-2016-02-19/share/backgrounds/nixos/nix-wallpaper-simple-blue.png";
      primary-color = "#3a4ba0";
      secondary-color = "#2f302f";
    };
    "org/gnome/desktop/peripherals/mouse".natural-scroll = false;

  };

  home.packages = with pkgs; [
    # ...
    # gnomeExtensions.user-themes
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar


    neovide
  ];
}
