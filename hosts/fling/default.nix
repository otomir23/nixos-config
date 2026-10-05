{ inputs }: {
  system = "x86_64-linux";
  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
  ];
}
