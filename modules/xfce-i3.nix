{ pkgs, ... }:


{

  ##########################################################################################################
  #
  #  NixOS's Configuration for Xfce with i3 Window Manager
  #
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
      xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
    };

    windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        ]
      }; 
  };


  environment.systemPackages = with pkgs; [
    wf-recorder # screen recording
    grim # taking screenshots
    slurp # selecting a region to screenshot
    # TODO replace by `flameshot gui --raw | wl-copy`

    rofi # A rofi inspired launcher for wlroots compositors such as sway/hyprland
    dunst # the notification daemon, the same as dunst

    # audio
    alsa-utils # provides amixer/alsamixer/...
    cava # for visualizing audio

    xfce.thunar # xfce4's file manager
    # gnome.nautilus
  ];
}
