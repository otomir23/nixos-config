{ ... }: {
  listen = {
    artist = "Aphex Twin";
    track = "Xtal";
    album = "Selected Ambient Works 85-92";
  };
  system = "x86_64-linux";
  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
