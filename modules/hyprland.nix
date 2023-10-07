{ pkgs, ... }:


{

  ##########################################################################################################
  #
  #  NixOS's Configuration for Hyprland Window Manager
  #
  #    hyprland: project starts from 2022, support Wayland, envolving fast, good looking, support Nvidia GPU.
  #
  ##########################################################################################################


  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw



  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
    # This will make xdg-open use the portal to open programs,
    # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
    # xdg-open is used by almost all programs to open a unknown file/uri
    # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr # for wlroots based compositors(hyprland/sway)
      xdg-desktop-portal-gtk # for gtk
      # xdg-desktop-portal-kde  # for kde
    ];
  };



  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "hyprland";
      lightdm.enable = false;
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  programs.hyprland = {
    enable = true;

    xwayland = {
      enable = true;
      # hidpi = true;
    };

    nvidiaPatches = true;
  };
  programs.light.enable = true; # monitor backlight control


  # thunar file manager(part of xfce) related options
  # programs.thunar.plugins = with pkgs.xfce; [
  #   thunar-archive-plugin
  #   thunar-volman
  # ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    waybar # the status bar
    hyprpaper #the wallpaper
    swayidle # the idle timeout
    swaylock # locking the screen
    wlogout # logout menu
    wl-clipboard # copying and pasting

    wf-recorder # screen recording
    grim # taking screenshots
    slurp # selecting a region to screenshot
    # TODO replace by `flameshot gui --raw | wl-copy`

    wofi # A rofi inspired launcher for wlroots compositors such as sway/hyprland
    dunst # the notification daemon, the same as dunst

    yad # a fork of zenity, for creating dialogs

    # audio
    alsa-utils # provides amixer/alsamixer/...
    cava # for visualizing audio
    mpd # for playing system sounds
    mpc-cli # command-line mpd client
    ncmpcpp # a mpd client with a UI
    networkmanagerapplet # provide GUI app: nm-connection-editor 

    # xfce.thunar # xfce4's file manager
    gnome.nautilus
  ];
}
