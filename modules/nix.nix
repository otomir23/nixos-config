({ config, lib, pkgs, ... }: let
  cfg = config.modules.nix;
  caches = {
    yukigram = {
      url = "https://yukigram-official.cachix.org";
      publicKey = "yukigram-official.cachix.org-1:PmmKVD/46LWDxfPWKol4rvoqvcdLqFq0aTtG/E1gdA8=";
    };
  };
  selectedCaches = map (name: caches.${name}) (lib.unique cfg.substituters);
in {
  options.modules.nix = {
    enable = lib.mkEnableOption "common Nix/Lix & nixpkgs configuration";
    substituters = lib.mkOption {
      type = lib.types.listOf (lib.types.enum (builtins.attrNames caches));
      default = [];
      example = [ "yukigram" ];
      description = "Additional substituters to enable from the cache registry.";
    };
  };
  config = lib.mkIf cfg.enable {
    nix = {
      package = pkgs.lixPackageSets.stable.lix;
      settings = {
        trusted-users = [ "@wheel" ];
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        substituters = [ "https://cache.nixos.org" ] ++ map (cache: cache.url) selectedCaches;
        trusted-public-keys = map (cache: cache.publicKey) selectedCaches;
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      nix-output-monitor
    ];
    programs.nix-ld.enable = true;
  };
})
