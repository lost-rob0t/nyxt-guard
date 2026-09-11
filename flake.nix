{
  description = "Installable StarIntel client package for Nyxt";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "nyxt-starintel";
            version = "0.1.0";
            src = self;

            installPhase = ''
              runHook preInstall

              mkdir -p "$out/share/nyxt-starintel/src" "$out/bin"
              cp src/*.lisp "$out/share/nyxt-starintel/src/"
              cp loader.lisp "$out/share/nyxt-starintel/loader.lisp"

              substitute scripts/install.sh "$out/bin/nyxt-starintel-install" \
                --replace-fail '@PACKAGE_ROOT@' "$out/share/nyxt-starintel"
              substitute scripts/uninstall.sh "$out/bin/nyxt-starintel-uninstall" \
                --replace-fail '@PACKAGE_ROOT@' "$out/share/nyxt-starintel"
              chmod +x "$out/bin/nyxt-starintel-install" "$out/bin/nyxt-starintel-uninstall"

              runHook postInstall
            '';
          };
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nyxt-starintel-install";
        };
        install = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nyxt-starintel-install";
        };
        uninstall = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nyxt-starintel-uninstall";
        };
      });

      checks = forAllSystems (system: {
        package = self.packages.${system}.default;
      });
    };
}
