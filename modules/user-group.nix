{ ... }:

{
  nix.settings.trusted-users = [ "mjpc13" ];

  users.groups = {
    mjpc13 = { };
    docker = { };
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mjpc13 = {
    # the hashed password with salt is generated by run `mkpasswd`.
    # hashedPassword = "";
    home = "/home/mjpc13";
    isNormalUser = true;
    description = "mjpc13";
    extraGroups = [
      "mjpc13"
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "adbusers"
      "libvirtd"
    ];
  };
}
