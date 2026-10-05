{ ... }: {
  system = "x86_64-linux";
  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
