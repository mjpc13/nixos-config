{ pkgs, ... }:
{
  imports = [
    # ./scripts #Import custom scripts
  ];


  # hyprland configs, based on https://github.com/notwidow/hyprland
  home.file.".config/hypr" = {
    source = ./hypr-conf;
    # copy the scripts directory recursively
    recursive = true;
  };
  home.file.".config/gtk-3.0" = {
    source = ./gtk-3.0;
    recursive = true;
  };
  home.file.".gtk-2.0".source = ./gtk-2.0;
  home.file.".config/wallpapers".source = ../wallpapers;

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };
  home.file.".config/wofi" = {
    source = ./wofi;
    recursive = true;
  };
  home.file.".config/nvim" = {
    source = ../base/programs/nvim;
    # copy the scripts directory recursively
    recursive = true;
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  fonts.fontconfig.enable = true;

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";

    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    #"LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    #"GBM_BACKEND" = "nvidia-drm";
    #"__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
  };

  # set Xcursor.theme & Xcursor.size in ~/.Xresources automatically
  home.pointerCursor = {
    name = "Qogir-dark";
    package = pkgs.qogir-theme;
    size = 64;
  };

}
