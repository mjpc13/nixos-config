{ pkgs, ... }:

pkgs.writeShellScriptBin "goto" ''
  echo "Hello world"
''
