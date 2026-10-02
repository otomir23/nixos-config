({ config, lib, ... }: let
  cfg = config.modules.home;
  sharedModules = map (file: ./modules/${file}) (builtins.attrNames (builtins.readDir ./modules));
in {
  options.modules.home = {
    enable = lib.mkEnableOption "Home Manager";
  };
  config = lib.mkIf cfg.enable {
    home-manager = {
      inherit sharedModules;

      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";

      extraSpecialArgs = {};
    };
  };
})
