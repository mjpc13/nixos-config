{ config, ... } @ args:

#############################################################
#
# My Thinkpad T470p laptop
#
#############################################################

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/core.nix
    ../../modules/user-group.nix

  ];

  # nixpkgs.overlays = import ../../../overlays args;

  # Enable binfmt emulation of aarch64-linux, this is required for cross compilation.
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];

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
    #efi = {
    #canTouchEfiVariables = true;
    #efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    #};
    systemd-boot.enable = true;
  };

  networking = {
    hostName = "mjpc13-t470p";
    #wireless.enable = true; # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networkmanager.enable = true;

    enableIPv6 = true; # disable ipv6
    # defaultGateway = "";
    nameservers = [ ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  # virtualisation.docker.storageDriver = "btrfs";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
