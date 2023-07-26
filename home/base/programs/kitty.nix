{ lib, pkgs, ... }:

###########################################################
#
# Kitty Configuration
#
# Useful Hot Keys for Linux:
#   1. New Tab: `ctrl + shift + t`
#   2. Close Tab: `ctrl + shift + q`
#   3. Switch Tab: `ctrl + shift + right` | `ctrl + shift + left`
#   4. Increase Font Size: `ctrl + shift + =` | `ctrl + shift + +`
#   5. Decrease Font Size: `ctrl + shift + -` | `ctrl + shift + _`
#   6. And Other common shortcuts such as Copy, Paste, Cursor Move, etc.
#
###########################################################
{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "FiraCode Font";
      # use different font size on macOS
      size = 14;
    };

    settings = {
      background_opacity = "0.95";
      macos_option_as_alt = true; # Option key acts as Alt on macOS
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };

  };
}
