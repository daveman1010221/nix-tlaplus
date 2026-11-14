{
  description = "The TLA+ tools (TLC, SANY, PlusCal) built from source at a pinned commit";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system:
      f { inherit system; pkgs = nixpkgs.legacyPackages.${system}; }
    );
  in {
    packages = forAllSystems ({ pkgs, ... }:
      let
        tlaplus = pkgs.callPackage ./pkgs/tlaplus.nix { release = import ./release.nix; };
      in {
        inherit tlaplus;
        default = tlaplus;
      });

    checks = forAllSystems ({ pkgs, system }:
      import ./tests {
        inherit (pkgs) runCommand;
        tlaplus = self.packages.${system}.tlaplus;
      });

    formatter = forAllSystems ({ pkgs, ... }: pkgs.alejandra);
  };
}
