{
  description = "Mario's NixOS Configuration";


  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    # To replace official cache with a mirror located on a closer place
    substituters = [ "https://cache.nixos.org/" ];

    # Community cache server
    extra-substituters = [ "https://nix-community.cachix.org" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ros-overlay = {
      url = "github:lopsided98/nix-ros-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";

    #Necessary for Surface Pro
    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      rev = "1bace8cedd4fa4ea9efb5ea17a06b9d92af86206";
      narHash = "sha256-2oJ6XMp1sR+uZstsWDVxzs0E8HULGXBMdx8cLJsj9+8=";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {

      "mjpc13-t470p" = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";

        # nixpkgs.overlays = [ nix-ros-overlay.overlay ];
        modules = [

          ./hosts/T470p-i5
          ./modules/gnome.nix
          
          inputs.nix-index-database.nixosModules.nix-index
          inputs.nix-ros-overlay.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            
            home-manager.users.mjpc13 = import ./home/thinkpad-gnome.nix;
          }
        ];
      };









      "mjpc13-framework" = nixpkgs.lib.nixosSystem {
	
	      system = "x86_64-linux";
        modules = [

          ./hosts/framework
          ./modules/gnome.nix

          inputs.nix-index-database.nixosModules.nix-index
          inputs.nvf.nixosModules.default



          
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            home-manager.extraSpecialArgs = {inherit inputs;};

            home-manager.users.mjpc13 = import ./home/framework-gnome.nix;

          }
        ];
      };












      "mjpc13-desktop" = nixpkgs.lib.nixosSystem {

        system = "x86_64-linux";

        modules = [

          ./hosts/desktop3070-3700x
          ./modules/gnome.nix

          inputs.nix-index-database.nixosModules.nix-index
          inputs.nix-ros-overlay.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mjpc13 = import ./home/desktop-gnome.nix;
          }
        ];
      };

      "mjpc13-surface" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [

          inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel

          ./hosts/surface-pro.nix
          ./modules/gnome.nix
          ./modules/user-group.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.mjpc13 = import ./home/surface-pro.nix;
          }
        ];
      };

    };
  };
}
