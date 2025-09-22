{
  description = "Build and run the Middleware for the Portuguese Citizen Card";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        openpace = pkgs.stdenv.mkDerivation {
          pname = "openpace";
          version = "1.1.1";

          src = pkgs.fetchFromGitHub {
            owner = "frankmorgner";
            repo = "openpace";
            rev = "ae0a677de61b2fe1d934e93b0e7e3fc530968f09";
            sha256 = "sha256-fLqwR2wH8RY7isT+W6g7idT/cBiuWpULYDBoNtF1P3o=";
          };

          nativeBuildInputs = with pkgs; [
            autoreconfHook
            pkg-config
            help2man
            gengetopt
          ];
          buildInputs = with pkgs; [ 
            openssl 
          ];

          preConfigure = ''
            autoreconf --verbose --install
          '';
          configureFlags = [
            "--enable-openssl-install"
          ];
        };

      in {
        packages.default = pkgs.stdenv.mkDerivation rec {
          name = "autenticacao-gov-bin";
          version = "3.13.0";
          src = pkgs.fetchurl {
            url = "https://github.com/amagovpt/autenticacao.gov/releases/download/v${version}/pteid-mw-${version}.flatpak";
            sha256 = "94a64575bbee117f5e602f0006f158db256dbc4cb06adc19f13b999f673625bd";
          };

          dontConfigure = true;
          dontBuild = true;

          nativeBuildInputs = with pkgs; [
            bash 
            binutils 
            ccid 
            cjson 
            curl 
            doxygen
            libGL 
            libgcc 
            libsForQt5.poppler 
            libsForQt5.qt5.wrapQtAppsHook 
            libzip 
            openjpeg 
            openpace 
            openssl 
            pcsclite 
            proot 
            qt5.qtbase 
            qt5.qtgraphicaleffects 
            qt5.qtquickcontrols 
            qt5.qtquickcontrols2 
            qt5.qttools 
            xercesc 
            xml-security-c 
          ];

          buildInputs = with pkgs; [
            autoPatchelfHook 
            bash 
            flatpak 
            git 
            ostree 
            patchelf
          ];

          unpackPhase = ''
            mkdir -p pteid
            ostree init --repo=pteid --mode=archive-z2
            ostree static-delta apply-offline --repo=pteid ${src} 
            commit_file=$(echo pteid/objects/*/*.commit | cut -d/ -f3- --output-delimiter="" | tr -d '\0')
            commit_basename=$(basename "$commit_file" .commit)
            ostree checkout --repo=pteid -U "$commit_basename" pteid_out
          '';

          installPhase = ''
            mkdir -p $out $out/lib 
            cp -r pteid_out/files/bin $out
            cp -r pteid_out/files/lib/libpteid* $out/lib/
            cp -r pteid_out/files/lib/libCMD* $out/lib/
            cp -r pteid_out/files/share $out

            cp $out/bin/eidguiV2 $out/bin/eidguiV2-unwrapped

            echo "#!/bin/env bash
            ${pkgs.proot}/bin/proot -b $out:/app $out/bin/eidguiV2-unwrapped \$@" > $out/bin/${name}
            chmod +x $out/bin/${name}
            cp $out/bin/${name} $out/bin/eidguiV2
          '';

          preFixup = ''
           find $out/lib -type f -name '*.so*' | while read lib; do
              patchelf --replace-needed libxml-security-c.so.20 libxml-security-c.so.30 "$lib"
            done

            # Auto patch all libraries
            autoPatchelf $out
          '';
        };
      });
}