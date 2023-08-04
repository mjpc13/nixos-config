{ pkgs, ... }:

pkgs.writeShellScriptBin "backup" ''
  source_dir="."

  timestamp=$(date +"%Y%m%d%H%M%S")
  mkdir ./backup

  for file in ./*; do
      if [[ -f "$file" ]]; then
          cp "$file" "./backup/$(basename $file)_$timestamp"
      fi
  done
  echo "Backup complete!"
''
