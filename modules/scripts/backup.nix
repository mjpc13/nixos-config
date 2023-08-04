{ pkgs, ... }:

pkgs.writeShellScriptBin "backup" ''
  source_dir="."
  backup_dir="./backup"

  timestamp=$(date +"%Y%m%d%H%M%S")

  for file in "${source_dir}"/*; do
      if [[ -f "$file" ]]; then
          cp "$file" "${backup_dir}/$(basename ${file})_${timestamp}"
      fi
  done
  echo "Backup complete!"
''
