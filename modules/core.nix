{ lib, pkgs, ... }:

{
  ###################################################################################
  #
  #  NixOS's core configuration suitable for all my machines
  #
  ###################################################################################

  # for nix server, we do not need to keep too much generations
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  # boot.loader.grub.configurationLimit = 10;
  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 2w";
  };

  # Manual optimise storage: nix-store --optimise
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # enable flakes globally
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = lib.mkDefault false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    aria2
    git # used by nix flakes
    # git-lfs # used by huggingface models
    nvd #compare different versions of NixOS


    # python, some times I may need to use python with root permission.
    (python310.withPackages (ps: with ps; [
      ipython
      pandas
      pyyaml
      numpy
      requests
    ]))

    # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
    (
      let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
        name = "fhs";
        targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [ pkgs.pkg-config ];
        profile = "export FHS=1";
        runScript = "bash";
        extraOutputsToInstall = [ "dev" ];
      })
    )
  ];


  # replace default editor with neovim
  environment.variables.EDITOR = "nvim";

  virtualisation.docker = {
    enable = true;
  };

  # for power management
  #services.power-profiles-daemon = {
  #enable = true;
  #};
  services.upower.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.dbus.enable = true;


  # all fonts are linked to /nix/var/nix/profiles/system/sw/share/X11/fonts
  fonts = {
    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome

      noto-fonts
      noto-fonts-cjk
      # noto-fonts-emoji
      noto-fonts-extra

      source-sans
      source-serif
      source-han-sans
      source-han-serif

      # nerdfonts
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })

      # (pkgs.callPackage ../../fonts/icomoon-feather-icon-font.nix { })
    ];
    # # Fonts
    #   fonts.fonts = with pkgs; [
    #     fira-code
    #     fira
    #     fira-code-symbols
    #     nerdfonts
    #     jetbrains-mono
    #   ];

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FiraCode Nerd Font" ];
      # emoji = [ "Noto Color Emoji" ];
    };
  };

  # Start SSH Agent
  programs.ssh.startAgent = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = with pkgs; [
  ## python, some times I may need to use python with root permission.
  #(python310.withPackages (ps: with ps; [
  #ipython
  #pandas
  #pyyaml
  #numpy
  #]))
  #];

  # PipeWire is a new low-level multimedia framework.
  # It aims to offer capture and playback for both audio and video with minimal latency.
  # It support for PulseAudio-, JACK-, ALSA- and GStreamer-based applications. 
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  sound.enable = false;
  # Disable pulseaudio, it conflicts with pipewire too.
  hardware.pulseaudio.enable = false;

  # enable bluetooth & gui paring tools - blueman
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # https://flatpak.org/setup/NixOS
  services.flatpak.enable = true;

  # security with polkit
  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;
  # security with gnome-kering
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # A key remapping daemon for linux. 
  # https://github.com/rvaiya/keyd
  # services.keyd = {
  #   enable = true;
  #   settings = {
  #     main = {
  #       # overloads the capslock key to function as both escape (when tapped) and control (when held) 
  #       capslock = "overload(control, esc)";
  #     };
  #   };
  # };

  services = {
    #dbus.packages = [ pkgs.gcr ];

    # geoclue2.enable = true;

    udev.packages = with pkgs; [
      gnome.gnome-settings-daemon
      # android-udev-rules
    ];
  };

  # android development tools, this will install adb/fastboot and other android tools and udev rules
  # programs.adb.enable = true;

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
  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bash
    zsh
    # nushell
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.bash;
}
