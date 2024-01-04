{ config, lib, pkgs, inputs, ... }:

{

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  #TODO: Change this for by-label instead of by-uuid
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ff2a9aed-86a2-45fe-9aad-2ab8fd40b8de";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E00B-D77F";
      fsType = "vfat";
    };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/52920b09-b15d-4ae6-accc-79e3f8f30b74"; }
    ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


# Stuff in configuration.nix
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mjpc13-surface";
  networking.networkmanager.enable = true;

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
  
  environment.systemPackages = with pkgs; [
    rnote
    firefox
    vim
    git
    bat
    vscodium
  ];
  nixpkgs.config.allowUnfree = true;

   # Fix the touch not working after suspend
 
  system.stateVersion = "23.05";
}

