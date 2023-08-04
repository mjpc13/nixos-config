{ pkgs, ... }:


# cd "$(${pkgs.fzf}/bin/fzf --preview "ls -la {}" | xargs -I {} dirname {})"
pkgs.writeShellScriptBin "op" ''
  ${pkgs.fzf}/bin/fzf | xargs -I {} ${pkgs.kitty}/bin/kitty -e ${pkgs.neovim}/bin/nvim "{}" 
''
