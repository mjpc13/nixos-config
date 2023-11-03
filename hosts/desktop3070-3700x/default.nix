{ config, ... } @ args:

#############################################################
#
# My Desktop
#
#############################################################

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/core.nix
    ../../modules/user-group.nix

  ];

  # Enable binfmt emulation of aarch64-linux, this is required for cross compilation.
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };




  # supported file systems, so we can mount any removable disks with these filesystems
  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    "ntfs"
    "fat"
    "vfat"
    "exfat"
  ];

  # Bootloader.
  boot.loader = {
    efi = {
	canTouchEfiVariables = true;
    #efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    systemd-boot.enable = true;
   # grub = {
      # enable = true;
      # device = "/dev/nvme0n1";
      # useOSProber = true;
      # efiSupport = true;
   # };
  };

  networking = {
    hostName = "mjpc13-desktop";
    #wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networkmanager.enable = true;

    enableIPv6 = true;
    # defaultGateway = "";
   # nameservers = [];
    # interfaces = {
    #   enp42s0 = {
    #     useDHCP = true;
    #     wakeOnLan = {
    #         enable = true;
    #     };
    #   };
    # };
  };


#Nvidia stuff

 # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed most of the time
    modesetting.enable = true;

        # Enable power management (do not disable this unless you have a reason to).
        # Likely to cause problems on laptops and with screen tearing if disabled.
        powerManagement.enable = true;

    # Use the open source version of the kernel module ("nouveau")
        # Note that this offers much lower performance and does not
        # support all the latest Nvidia GPU features.
        # You most likely don't want this.
    # Only available on driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # opengl.driSupport32Bit = true;
  };

  # hardware.opengl.driSupport32Bit = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
