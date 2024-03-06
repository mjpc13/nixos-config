{ pkgs, lib, config, ... }:

{

  options.gnome.test = lib.mkOption {
    type = lib.types.int;
    default = 2;
  };
  # GTK Options
  config = {
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

    # Config options
    home.file.".config/wallpapers".source = ../wallpapers;

    home.file.".config/nvim" = {
      source = ../base/programs/nvim;
      recursive = true;
    };

    # DCONF Settings
    dconf.settings = {
      # To know what options you have, Run:
      # $ dconf watch /
      # Then go to preferences and edit the different settings


      "org/gnome/shell" = {

        disable-user-extensions = false;

        #For gnome extensions
        enabled-extensions = [

          "caffeine@patapon.info"
          "arcmenu@arcmenu.com"
          "mediacontrols@cliffniff.github.com"
          "space-bar@luchrioh"
          "tactile@lundal.io"
          "just-perfection-desktop@just-perfection"
          "blur-my-shell@aunetx"
        ];


        favorite-apps = [
          "firefox.desktop"
          "kitty.desktop"
          "slack.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };

      # "/org/gnome/shell/extensions/arcmenu".arc-menu-icon = "63";
      "org/gnome/shell/extensions/mediacontrols" = {
        label-width = 0;
        show-control-icons-seek-forward = false;
        show-control-icons-seek-back = false;
        show-player-icon = false;
      };
      "org/gnome/shell/extensions/just-perfection" = {
        keyboard-layout = false;
        clock-menu-position = config.gnome.test;
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
        picture-uri = "file:///home/mjpc13/.config/wallpapers/nix-nineish-light.png";
        picture-uri-dark = "file:///home/mjpc13/.config/wallpapers/nix-nineish-dark.png";
        primary-color = "#3a4ba0";
        secondary-color = "#2f302f";
      };

      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///home/mjpc13/.config/wallpapers/nix-dracula.png";
        primary-color = "#3a4ba0";
        secondary-color = "#2f302f";
      };
      "org/gnome/desktop/peripherals/mouse".natural-scroll = false;

    };

    home.packages = with pkgs; [
      # ...
      # gnomeExtensions.user-themes
      # gnomeExtensions.vitals
      gnomeExtensions.dash-to-panel
      gnomeExtensions.space-bar
      gnomeExtensions.tactile

      # gnomeExtensions.multimonitors
      gnomeExtensions.blur-my-shell
      gnomeExtensions.media-controls
      gnomeExtensions.caffeine

      # gnomeExtensions.easyscreencast
      gnomeExtensions.arcmenu
      gnomeExtensions.just-perfection
      # gnomeExtensions.floating-dock



      neovide
    ];
  };
}
