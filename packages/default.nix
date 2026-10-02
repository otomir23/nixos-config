{ inputs }: pkgs: let
  system = pkgs.stdenv.hostPlatform.system;
in {
  jetbrains-fleet = pkgs.callPackage ./fleet.nix {};
  justlauncher = pkgs.callPackage ./justlauncher.nix {};
  nightfox-gtk-theme = pkgs.callPackage ./nightfox-gtk-theme.nix {};
  tidaLuna = pkgs.callPackage ./tidaluna.nix {
    injections = inputs.tidaLuna.packages.${system};
  };

  # packages from flakes that dont provide their own overlay
  helium = inputs.helium-nix.packages.${system}.default;
  yukigram = inputs.yukigram.packages.${system}.nonisolated;
}
