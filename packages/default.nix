{ inputs }: pkgs: let
  system = pkgs.stdenv.hostPlatform.system;
  flakeMaintainers = import ../maintainers.nix;
  callPackage = path: params: pkgs.callPackage path (params // { inherit flakeMaintainers; });
in {
  jetbrains-fleet = callPackage ./fleet.nix {};
  justlauncher = callPackage ./justlauncher.nix {};
  nightfox-gtk-theme = callPackage ./nightfox-gtk-theme.nix {};
  tidaLuna = callPackage ./tidaluna.nix {
    injections = inputs.tidaLuna.packages.${system};
  };

  # packages from flakes that dont provide their own overlay
  helium = inputs.helium-nix.packages.${system}.default;
  yukigram = inputs.yukigram.packages.${system}.nonisolated;
}
