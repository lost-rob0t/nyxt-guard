{
  description = "Installable modular extension package for the Nyxt browser";

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
            pname = "nyxt-guard";
            version = "0.1.0";
            src = self;

            installPhase = ''
              runHook preInstall

              mkdir -p "$out/share/nyxt-guard/src" "$out/share/nyxt-guard/modules" "$out/bin"
              cp src/*.lisp "$out/share/nyxt-guard/src/"
              if ls modules/*.lisp >/dev/null 2>&1; then
                cp modules/*.lisp "$out/share/nyxt-guard/modules/"
              fi
              cp loader.lisp "$out/share/nyxt-guard/loader.lisp"

              substitute scripts/install.sh "$out/bin/nyxt-guard-install" \
                --replace-fail '@PACKAGE_ROOT@' "$out/share/nyxt-guard"
              substitute scripts/uninstall.sh "$out/bin/nyxt-guard-uninstall" \
                --replace-fail '@PACKAGE_ROOT@' "$out/share/nyxt-guard"
              chmod +x "$out/bin/nyxt-guard-install" "$out/bin/nyxt-guard-uninstall"

              runHook postInstall
            '';
          };
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nyxt-guard-install";
        };
        install = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nyxt-guard-install";
        };
        uninstall = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nyxt-guard-uninstall";
        };
      });

      checks = forAllSystems (system: {
        package = self.packages.${system}.default;
      });
    };
}
