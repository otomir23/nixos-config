{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tidaLuna = {
      url = "github:Inrixia/TidaLuna";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bunny = {
      url = "github:oljoi/bunny";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yukigram = {
      url = "github:yukigram/yukigram/release";
      # yuki please i want to use my nixpkgs :c
    };
    helium-nix = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ligma = {
      url = "github:otomir23/ligma";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tetra-nurpkgs = {
      url = "github:tetra-fox/nurpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: with builtins; let
    # list of supported systems for VMs, other packages and devshells (best-effort, not guaranteed)
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

    # overlay with custom packages from this repo that i maintain
    mkPackages = (import ./packages) {
      inherit inputs;
    };
    customPackagesOverlay = (final: prev: mkPackages final);

    # list of all shared NixOS modules
    sharedModules = map (file: ./modules/${file}) (attrNames (readDir ./modules));
    # list of all defined hostnames, each is a subdirectory inside ./hosts
    hostnames = attrNames (readDir ./hosts);
    # function that builds a NixOS config given a hostname present in ./hosts
    buildHostConfig = hostname: let
      hostpath = ./hosts/${hostname}; # host directory that contains its configuration and metadata
      metadata = import hostpath { inherit inputs; }; # default.nix is the metadata file
    in {
      system = metadata.system;
      modules = [
        # flake input modules
        inputs.home-manager.nixosModules.home-manager
        inputs.bunny.nixosModules.bunny
        inputs.musnix.nixosModules.musnix

        # overlays
        ({ ... }: {
          nixpkgs.overlays = [
            inputs.ligma.overlays.default
            inputs.tetra-nurpkgs.overlays.default
            customPackagesOverlay
          ];
        })

        # dynamic per-host modules
        ({ ... }: { networking.hostName = hostname; }) # apply hostname
        ({ ... }: { nix.registry.nixpkgs.flake = nixpkgs; }) # this fixes nixpkgs (for e.g. "nix shell") to match the system nixpkgs
      ]
        ++ sharedModules # shared modules
        ++ metadata.modules; # per-host modules
    };
    # function builds a NixOS VM config given a hostname present in ./hosts
    buildHostVMConfig = hostname: let
      config = buildHostConfig hostname;
    in config // {
      modules = config.modules ++ [
        (nixpkgs + /nixos/modules/virtualisation/build-vm.nix)
        ({ ... }: { modules.guest.enable = true; }) # enable guest VM config module
      ];
    };
    createHost = hostname: nixpkgs.lib.nixosSystem (buildHostConfig hostname);
    createVM = hostname: (nixpkgs.lib.nixosSystem (buildHostVMConfig hostname)).config.system.build.vm;

    vmPackages = listToAttrs (map (hostname: { name = "${hostname}-vm"; value = createVM hostname; }) hostnames);
  in {
    packages = listToAttrs (map (system: {
      name = system;
      value = vmPackages // (mkPackages nixpkgs.legacyPackages.${system});
    }) supportedSystems);
    nixosConfigurations = listToAttrs (map (hostname: {
      name = hostname;
      value = createHost hostname;
    }) hostnames);
    overlays.default = customPackagesOverlay;
  };
}
