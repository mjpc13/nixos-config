{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ../modules/core.nix
  ];

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

  #Custom overlay
  nixpkgs.overlays = [ (final: prev: {
    ipts-sleep = final.writeShellApplication{
      name = "ipts-sleep";
      text = ''
        case $1 in 
        pre)
	  systemctl stop iptsd
	  modprobe -r ipts
	  ;;
        post)
   	  modprobe ipts
	  sytemctl start iptsd
	  ;;
        esac
      '';
      };
  })];

  environment.systemPackages = with pkgs; [
    rnote
    firefox
    vim
    neovim
    git
    bat
    vscodium
    ipts-sleep
  ];
  nixpkgs.config.allowUnfree = true;

  # Create systemd service to fix the touch not working after suspend
  systemd.services.ipts-sleep= {
      # this service is "wanted by" (see systemd man pages, or other tutorials) the system 
      # level that allows multiple users to login and interact with the machine non-graphically 
      # (see the Red Hat tutorial or Arch Linux Wiki for more information on what each target means) 
      # this is the "node" in the systemd dependency graph that will run the service
      wantedBy = [ "sleep.target" ];
      # systemd service unit declarations involve specifying dependencies and order of execution
      # of systemd nodes; here we are saying that we want our service to start after the network has 
      # set up (as our IRC client needs to relay over the network)
      before = [ "sleep.target" ];
      description = "IPTS sleep hook.";
      #stopWhenUnneeded="yes";
      serviceConfig = {
        # see systemd man pages for more information on the various options for "Type"
        Type = "oneshot";
        RemainAfterExit = "yes";
        # the command to execute when the service starts up 
        ExecStart=''${pkgs.ipts-sleep}/bin/ipts-sleep pre'';
        # and the command to execute         
        ExecStop=''${pkgs.ipts-sleep}/bin/ipts-sleep post'';
      };
   };

  system.stateVersion = "23.05";
}
